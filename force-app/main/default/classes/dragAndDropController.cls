public with sharing class dragAndDropController {
    @AuraEnabled
    public static Attachment getProfilePicture(Id parentId) {
        // Attachment permissions are set in parent object (Contact)
            try{
                if (!Schema.sObjectType.Contact.isAccessible()) {
                    throw new System.NoAccessException();
                // return null;
                }
                return [SELECT Id, Name, LastModifiedDate, ContentType FROM Attachment 
                    WHERE parentid=:ParentId AND ContentType IN ('image/png', 'image/jpeg', 'image/gif') 
                    ORDER BY LastModifiedDate DESC LIMIT 1];
            }catch(Exception e){
                System.debug('eror');
                return null;
            }
    }
     
    @AuraEnabled
    public static Id `(Id parentId, String fileName, String base64Data, String contentType) { 
        // Edit permission on parent object (Contact) is required to add attachments
     try{
        System.debug('parentId : '+parentId);
        System.debug('fileName : '+fileName);
        System.debug('contentType : '+contentType);
        System.debug('base64Data : '+base64Data);
        

        if (!Schema.sObjectType.Contact.isUpdateable()) {
            throw new System.NoAccessException();
          //  return null;
        }
 
        Attachment attachment = new Attachment();
        attachment.parentId = parentId;
        attachment.body = EncodingUtil.base64Decode(base64Data);
        attachment.name = fileName;
        attachment.contentType = contentType;
        insert attachment;
        System.debug('atch : '+attachment);
        return attachment.id;
    }catch(Exception e){
        System.debug('Error Save : '+e.getMessage);
        return null;
            }
    }
}
