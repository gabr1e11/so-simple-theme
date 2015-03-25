---
id: 24
title: CSS, Blogger and Simple template transparency
author: rcano
layout: post
guid: http://www.robertocano.es/?p=24
permalink: /2013/02/css-blogger-and-simple-template-transparency/
blogger_blog:
  - www.gabriell.es
blogger_author:
  - Roberto Cano
blogger_permalink:
  - /2013/02/css-blogger-and-simple-template.html
blogger_internal:
  - /feeds/1837616560811891684/posts/default/2674425766732633489
categories:
  - Programming
---
It may seem quite obvious for any HTML/CSS developer how to do this, but I struggled for 2 hours to find out how to set a semi-transparent background while using the Simple template of Blogger. Usually websites indicate how to do it while using the Dynamic template. My main problem was to know how the pane component was called internally. Finally I could find the solution in this <a href="http://www.bloggeries.com/forum/showthread.php?t=26163" target="_blank">thread</a>&nbsp;from <a href="http://www.bloggeries.com/" target="_blank">Bloggeries</a>.

You must go to your Blogger configuration and click on **Template**. Then click on **Customize. **This will bring the template customization page. Click then in **Advance**, go to the bottom of the new categories pane and click on **Add CSS**. Here you can add the following lines:

<pre>.content-inner {&nbsp;<br />background-color: rgba(255, 255, 255, 0.7);<br />}<br /></pre>

Change the **255**&nbsp;values to the RGB values you want for the background and the **0.7**&nbsp;to the alpha setting you prefer (from **0.0**&nbsp;to **1.0**). Click on **Apply to Blog**&nbsp;at the upper right corner and enjoy the benefits of alpha blending in your blog!

Remember this is valid for the **Simple Template**&nbsp;of Blogger. I didn&#8217;t try with other templates.