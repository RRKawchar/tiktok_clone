import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/conitrollers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({Key? key, required this.id}) : super(key: key);
 final TextEditingController _commentController = TextEditingController();
 CommentController commentController= Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                    return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {

                        final comments=commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comments.profilePhoto),
                          ),
                          title: Row(
                            children:[
                              Text(
                                "${comments.username}  ",
                                style:const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red),
                              ),
                              Text(
                                comments.comment,
                                style:const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children:[
                              Text(
                                tago.format(comments.datePublished.toDate()),
                                style:const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${comments.likes.length} likes",
                                style:const TextStyle(fontSize: 12, color: Colors.white),
                              )
                            ],
                          ),
                          trailing: const Icon(
                            Icons.favorite,
                            size: 25,
                            color: Colors.red,
                          ),
                        );
                      },
                    );
                  }
                ),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style:const TextStyle(
                    fontSize: 16,color: Colors.white,
                  ),
                  decoration:const InputDecoration(
                    labelText: "comment",
                    labelStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red
                      ),
                    ),
                    focusedBorder:  UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red
                      ),
                    ),
                  ),

                ),
                trailing: TextButton(
                  onPressed: ()=>commentController.postComment(_commentController.text),
                  child: const Text("Send",style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
