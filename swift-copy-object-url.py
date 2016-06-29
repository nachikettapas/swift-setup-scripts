# object copy is not present (at time this script is made) in swiftclient
# this script builds the full curl command needed
# it only builds up the URL, doesn't actually make any request to Swift

# to use:
# (1) replace all of the values (url, account, token, containers,
#     and object) as indicated
# (2) run this script
# (3) copy output
# (4) paste to command line

# OPTION - there are 2 different ways of copying an object in Swift:
# (a) using the COPY verb
# (b) using a PUT along with X-Copy-From HTTP header
# adjust 'use_copy_verb' as needed

# if you're using SAIO, you shouldn't have to change the url
public_url = 'http://127.0.0.1:8080/v1'

# use COPY verb? setting to False will make use of PUT and X-Copy-From
use_copy_verb = True

# replace these values
token = 'AUTH_tk543c66ee54c64257ab9b5a229c25825e'
swift_account = 'test'
src_container = 'my-src-container'
src_object = 'my-object'
dest_container = 'my-dest-container'
dest_object = src_object  # by default, use same object name


src_url = '%s/AUTH_%s/%s/%s' % (public_url, swift_account, src_container, src_object)
dest_url = '%s/AUTH_%s/%s/%s' % (public_url, swift_account, dest_container, dest_object)
auth_token_hdr = 'X-Auth-Token: %s' % token

if use_copy_verb:
    curl_cmd = 'curl -i -X COPY -H "%s" -H "Destination: /%s/%s" %s' % (auth_token_hdr, dest_container, dest_object, src_url)
else:
    curl_cmd = 'curl -i -X PUT -H "%s" -H "X-Copy-From: /%s/%s" %s' % (auth_token_hdr, src_container, src_object, dest_url)

print(curl_cmd)

