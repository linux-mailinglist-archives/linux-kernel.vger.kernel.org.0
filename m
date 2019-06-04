Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA333F20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 08:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfFDGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 02:44:27 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:1863 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbfFDGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:44:26 -0400
X-UUID: 2147b8c1ae644262ad21e1bc246d6d60-20190604
X-UUID: 2147b8c1ae644262ad21e1bc246d6d60-20190604
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1706568245; Tue, 04 Jun 2019 14:44:20 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Jun
 2019 14:44:18 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Jun 2019 14:44:18 +0800
Message-ID: <1559630658.8487.61.camel@mhfsdcap03>
Subject: Re: [v3 PATCH] usb: create usb_debug_root for gadget only
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 4 Jun 2019 14:44:18 +0800
In-Reply-To: <87sgsv2n54.fsf@linux.intel.com>
References: <cffd6d75f69e4d908c8f39b8a60ddae27d6b7c88.1559028752.git.chunfeng.yun@mediatek.com>
         <87k1ebj8vt.fsf@linux.intel.com> <1559201499.8487.40.camel@mhfsdcap03>
         <87sgsv2n54.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-31 at 08:44 +0300, Felipe Balbi wrote:
> Hi,
> 
> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> 
> > Hi Felipe,
> > On Tue, 2019-05-28 at 11:11 +0300, Felipe Balbi wrote:
> >> Hi,
> >> 
> >> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> >> > diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> >> > index 7fcb9f782931..88b3ee03a12d 100644
> >> > --- a/drivers/usb/core/usb.c
> >> > +++ b/drivers/usb/core/usb.c
> >> > @@ -1190,7 +1190,7 @@ EXPORT_SYMBOL_GPL(usb_debug_root);
> >> >  
> >> >  static void usb_debugfs_init(void)
> >> >  {
> >> > -	usb_debug_root = debugfs_create_dir("usb", NULL);
> >> > +	usb_debug_root = debugfs_create_dir(USB_DEBUG_ROOT_NAME, NULL);
> >> >  	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
> >> >  			    &usbfs_devices_fops);
> >> >  }
> >> 
> >> might be a better idea to move this to usb common. Then have a function
> >> which can be called by both host and gadget to maybe create the
> >> directory:
> >> 
> >> static struct dentry *usb_debug_root;
> >> 
> >> struct dentry *usb_debugfs_init(void)
> >> {
> >> 	if (!usb_debug_root)
> >>         	usb_debug_root = debugfs_create_dir("usb", NULL);
> >> 
> >> 	return usb_debug_root;
> >> }
> >> 
> >> 
> >> Then usb core would be updated to something like:
> >> 
> >> static void usb_core_debugfs_init(void)
> >> {
> >> 	struct dentry *root = usb_debugfs_init();
> >> 
> >> 	debugfs_create_file("devices", 0444, root, NULL, &usbfs_devices_fops);
> >> }
> >> 
> > I find a problem when move usb_debugfs_init() and usb_debugfs_cleanup()
> > into usb common, it's easy to create "usb" directory, but difficult to
> > cleanup it:
> >
> > common/common.c
> >
> > struct dentry *usb_debugfs_init(void)
> > {
> >     if (!usb_debug_root)
> >         usb_debug_root = debugfs_create_dir("usb", NULL);
> >
> >     return usb_debug_root;
> > }
> >
> > void usb_debugfs_cleanup(void)
> > {
> >     debugfs_remove_recursive(usb_debug_root);
> >     usb_debug_root = NULL;
> > }
> >
> > core/usb.c
> >
> > static void usb_core_debugfs_init(void)
> > {
> >     struct dentry *root = usb_debugfs_init();
> >
> >     debugfs_create_file("devices", 0444, root, NULL,
> > &usbfs_devices_fops);
> > }
> >
> > static int __init usb_init(void)
> > {
> >     ...
> >     usb_core_debugfs_init();
> >     ...
> > }
> >
> > static void __exit usb_exit(void)
> > {
> >     ...
> >     usb_debugfs_cleanup();
> >     // will be error, gadget may use it.
> >     ...
> > }
> >
> > gadget/udc/core.c
> >
> > static int __init usb_udc_init(void)
> > {
> >     ...
> >     usb_debugfs_init();
> >     ...
> > }
> >
> > static void __exit usb_udc_exit(void)
> > {
> >     ...
> >     usb_debugfs_cleanup();
> >     // can't cleanup in fact, usb core may use it.
> > }
> >
> > How to handle this case? introduce a reference count? do you have any
> > suggestion?
> 
> I guess a simple refcount is the way to go:
> 
> struct dentry *usb_debugfs_init(void)
> {
> 	if (!usb_debug_root)
> 		usb_debug_root = debugfs_create_dir("usb", NULL);
> 
> 	usb_debug_root_refcnt++;
> 	return usb_debug_root;
> }
> 
> void usb_debugfs_cleanup(void)
> {
> 	if (!(--usb_debug_root_refcnt)) {
> 		debugfs_remove_recursive(usb_debug_root);
> 		usb_debug_root = NULL;
> 	}
> }
I'll try it, thanks

> 
> Or something along those lines
> 


