Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8161C3BF97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 00:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbfFJWs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 18:48:57 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33088 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390340AbfFJWs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:48:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE2758EE182;
        Mon, 10 Jun 2019 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560206935;
        bh=mb6IzwM78BT/viG2YgEvk/s6gBgJO14fZN6QaNMTcf0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jrk/1QedcyxDoeH/nG3zibD+xvky2BjHsl77hFVLLkn8RtjNGKG+ui2IHJJiFOsAd
         mrCUm9W/U0SZA9+ac9aDNJftoFL118Pk1K8N3fUWBj56jSOc2W9U+f3NP4SgzM5FuL
         /48jgcNYp4iiQH+T4GgcAYd1ZlKL+h36987ETg1E=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ASJhwJ4X_a3j; Mon, 10 Jun 2019 15:48:55 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3B0818EE105;
        Mon, 10 Jun 2019 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560206935;
        bh=mb6IzwM78BT/viG2YgEvk/s6gBgJO14fZN6QaNMTcf0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jrk/1QedcyxDoeH/nG3zibD+xvky2BjHsl77hFVLLkn8RtjNGKG+ui2IHJJiFOsAd
         mrCUm9W/U0SZA9+ac9aDNJftoFL118Pk1K8N3fUWBj56jSOc2W9U+f3NP4SgzM5FuL
         /48jgcNYp4iiQH+T4GgcAYd1ZlKL+h36987ETg1E=
Message-ID: <1560206933.3698.27.camel@HansenPartnership.com>
Subject: Re: [PATCH] drivers/ata: print trim features at device
 initialization
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Mon, 10 Jun 2019 15:48:53 -0700
In-Reply-To: <b554c428-417e-5fef-1776-87a4db1d674a@yandex-team.ru>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
         <yq1wohxib7t.fsf@oracle.com>
         <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
         <048ed77f-8faa-fb67-c6bc-10d953f52f89@yandex-team.ru>
         <1560116241.3324.19.camel@HansenPartnership.com>
         <b554c428-417e-5fef-1776-87a4db1d674a@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-10 at 10:49 +0300, Konstantin Khlebnikov wrote:
> On 10.06.2019 0:37, James Bottomley wrote:
> > On Sat, 2019-06-08 at 17:13 +0300, Konstantin Khlebnikov wrote:
> > > > On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun 07,
> > > > 2019
> > > > at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
> > > >   >
> > > >   > Do we really need to spam dmesg with even more ATA
> > > > crap?  What
> > > > about
> > > >   > a sysfs file that can be read on demand instead?
> > > >   >
> > > > 
> > > > Makes sense.
> > > > 
> > > > Trim state is exposed for ata_device:
> > > > /sys/class/ata_device/devX.Y/trim
> > > > but there is no link from scsi device to ata device so they
> > > > hard to match.
> > > > 
> > > > I'll think about it.
> > > 
> > > Nope. There is no obvious way to link scsi device with
> > > ata_device. ata_device is built on top of "transport_class" and
> > > "attribute_container". This some extremely over engineered sysfs
> > > framework used only in ata/scsi. I don't want to touch this.
> > 
> > You don't need to know any of that.  The problem is actually when
> > the ata transport classes were first created, the devices weren't
> > properly parented.  What should have happened, like every other
> > transport class, is that the devices should have descended down to
> > the scsi device as the leaf in an integrated fashion.  Instead,
> > what we seem to have is three completely separate trees.
> > 
> > So if you look at a SAS device, you see from the pci device:
> > 
> > host2/port-2:0/end_device-2:0/target2:0:0/2:0:0:0/block/sdb/sdb1
> > 
> > But if you look at a SATA device, you see three separate paths:
> > 
> > ata3/host3/target3\:0\:0/3\:0\:0\:0/block/sda/sda1
> > ata3/link3/dev3.0/ata_device/dev3.0
> > ata3/ata_port/ata3
> > 
> > Instead of an integrated tree
> > 
> > Unfortunately, this whole thing is unfixable now.  If I integrate
> > the tree properly, the separate port and link directories will get
> > subsumed and we won't be able to recover them with judicious
> > linking so scripts relying on them will break.  The best we can
> > probably do is add additional links with what we have.
> > 
> > To follow the way we usually do it, there should be a link from the
> > ata device to the scsi target, but that wouldn't help you find the
> > "trim" files, so it sounds like you want a link from the scsi
> > device to the ata device, which would?
> 
> Yes, I'm talking about link from scsi device to leaf ata_device node.
> 
> In libata scsi_device has one to one relation with ata_device.
> So making link like /sys/class/block/sda/device/ata_device should be
> possible easy.
> But I haven't found implicit reference from struct ata_device to
> ata_device in sysfs.

If that's all you want, it is pretty simple modulo the fact we can only
get at the tdev, not the lower transport device, which is what you
want, but at least it's linear from the symlink.

The attached patch should do this.

Now I see this for my non-sas device:

# ls -l /sys/class/scsi_device/3\:0\:0\:0/device/ata_device
lrwxrwxrwx 1 root root 0 Jun 10 13:39 /sys/class/scsi_device/3:0:0:0/device/ata_device -> ../../../link3/dev3.0

James

---

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 391ac0503dc0..b644336a6d65 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4576,7 +4576,20 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 			sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
 						 NULL);
 			if (!IS_ERR(sdev)) {
+				int r;
+
 				dev->sdev = sdev;
+				/* this is a sysfs stupidity: we don't
+				 * care if the link actually gets
+				 * created: there's no error handling
+				 * for failure and we continue on
+				 * regardless, but we have to discard
+				 * the return value like this to
+				 * defeat unused result checking */
+				r = sysfs_create_link(&sdev->sdev_gendev.kobj,
+						      &dev->tdev.kobj,
+						      "ata_device");
+				(void)r;
 				scsi_device_put(sdev);
 			} else {
 				dev->sdev = NULL;
@@ -4703,6 +4716,7 @@ static void ata_scsi_remove_dev(struct ata_device *dev)
 		ata_dev_info(dev, "detaching (SCSI %s)\n",
 			     dev_name(&sdev->sdev_gendev));
 
+		sysfs_remove_link(&sdev->sdev_gendev.kobj, "ata_device");
 		scsi_remove_device(sdev);
 		scsi_device_put(sdev);
 	}
