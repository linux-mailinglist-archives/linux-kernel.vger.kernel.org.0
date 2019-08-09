Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBEC882B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436988AbfHIShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 14:37:38 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:48310 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436950AbfHIShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:37:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6A41918224D7B;
        Fri,  9 Aug 2019 18:37:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:965:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2196:2198:2199:2200:2393:2559:2562:2828:2895:2918:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4385:4390:4395:4423:4605:5007:6119:7903:7904:8531:9586:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12555:12740:12760:12895:13255:13439:14181:14659:14721:21063:21080:21451:21627:30012:30029:30054:30056:30064:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: fall77_7c2fc6493ef15
X-Filterd-Recvd-Size: 4313
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Aug 2019 18:37:33 +0000 (UTC)
Message-ID: <2e93e4057d1f95680bdd6f7f7d754800b7c87ac9.camel@perches.com>
Subject: Re: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
From:   Joe Perches <joe@perches.com>
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Date:   Fri, 09 Aug 2019 11:37:31 -0700
In-Reply-To: <1565358624103.3694@mentor.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 13:50 +0000, Schmid, Carsten wrote:
> When a resource is freed and has children, the childrens are
> left without any hint that their parent is no more valid.
> This caused at least one use-after-free in the xhci-hcd using
> ext-caps driver when platform code released platform devices.
> 
> Fix this by setting child's parent to zero and warn.
> 
> Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
> ---
> Rationale:
> When hunting for the root cause of a crash on a 4.14.86 kernel, i
> have found the root cause and checked it being still present
> upstream. Our case:
> Having xhci-hcd and intel_xhci_usb_sw active we can see in
> /proc/meminfo: (exceirpt)
>   b3c00000-b3c0ffff : 0000:00:15.0
>     b3c00000-b3c0ffff : xhci-hcd
>       b3c08070-b3c0846f : intel_xhci_usb_sw
> intel_xhci_usb_sw being a child of xhci-hcd.
> 
> Doing an unbind command
> echo 0000:00:15.0 > /sys/bus/pci/drivers/xhci_hcd/unbind
> leads to xhci-hcd being freed in __release_region.
> The intel_xhci_usb_sw resource is accessed in platform code
> in platform_device_del with
>                 for (i = 0; i < pdev->num_resources; i++) {
>                         struct resource *r = &pdev->resource[i];
>                         if (r->parent)
>                                 release_resource(r);
>                 }
> as the resource's parent has not been updated, the release_resource
> uses the parent:
>         p = &old->parent->child;
> which is now invalid.
> Fix this by marking the parent invalid in the child and give a warning
> in dmesg.
> ---
> Advised by Greg (thanks):
> Try resending it with at least the people who get_maintainer.pl says has
> touched that file last in it. [CS:done]
> 
> Also, Linus is the unofficial resource.c maintainer.  I think he has a
> set of userspace testing scripts for changes somewhere, so you should
>  cc: him too.  And might as well add me :) [CS:done]
[]
> diff --git a/kernel/resource.c b/kernel/resource.c
[]
> @@ -1200,6 +1200,15 @@ void __release_region(struct resource *parent, resource_size_t start,
>                         write_unlock(&resource_lock);
>                         if (res->flags & IORESOURCE_MUXED)
>                                 wake_up(&muxed_resource_wait);
> +
> +                       write_lock(&resource_lock);
> +                       if (res->child) {
> +                               printk(KERN_WARNING "__release_region: %s has child %s,"
> +                                               "invalidating childs parent\n",
> +                                               res->name, res->child->name);

Please coalesce the format because there is likely an unintentional
missing space after the comma, and use pr_warn, %s and __func__

				pr_warn("%s: %s has child %s, invalidating child's parent\n",
					__func__, res->name, res->child->name);


