Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D208AF6C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 02:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfKKBuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 20:50:51 -0500
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:51003 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726743AbfKKBuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:50:50 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 68D4D181D341A;
        Mon, 11 Nov 2019 01:50:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1963:2194:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:7875:7904:10004:10400:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13019:13161:13229:13439:14093:14096:14097:14181:14659:14721:21080:21627:30045:30054:30056:30060:30075:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:77,LUA_SUMMARY:none
X-HE-Tag: corn13_7079ff6b2031
X-Filterd-Recvd-Size: 4714
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Nov 2019 01:50:48 +0000 (UTC)
Message-ID: <56f05dfb50dfc506a9cab539e522e8f80c738a4b.camel@perches.com>
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Date:   Sun, 10 Nov 2019 17:50:32 -0800
In-Reply-To: <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
         <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
         <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-11-10 at 14:35 -0800, Linus Torvalds wrote:
> On Sun, Nov 10, 2019 at 2:01 PM Joe Perches <joe@perches.com> wrote:
> > trivia:
> > 
> > This idiom '!!(logical test)' is odd and redundant.
> > Logical test result is already 0 or 1, no !! is unnecessary.
> 
> You are of course correct.
> 
> I have to say, I personally have always disliked the idiomatic C "!!"
> pattern. I don't think it reads well, although that's probably "C
> cultural" - once you are used to the pattern, you don't think of it as
> anything else.
> 
> Personally, I prefer "x != 0" over "!!x" since it reads much better to
> a human, and is equally legible whether you're used to the !! pattern
> or not.
> 
> C is not perl, the Obfuscated C contest not-withstanding.
> 
> And since modern C has bool, if you really want to use a cast-to-bool
> instead of "x != 0", I think doing exactly that is preferable to "!!".
> 
> So I think both "x != 0" and "(bool)x" are preferable to "!!x", and
> would also have made it obvious how odd and redundant the test was in
> this case.
> 
> But "!!x" is shorter, of course. And it you learnt C with that pattern
> it looks obvious.

The !! logical usage is not particularly common in the kernel.
There seems to be only a couple/few dozen.

$ git grep -P '\!\!\s*\([^\)]+[\!=]=.*\);'
drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c:     info->realtek_eDPToLVDS = !!(lvds->dplvdsrxid == eDP_TO_LVDS_REALTEK_ID);
drivers/iio/resolver/ad2s1200.c:                gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
drivers/infiniband/hw/mlx5/mr.c:        MLX5_SET(mkc, mkc, en_rinval, !!((type == IB_MW_TYPE_2)));
drivers/leds/leds-max77693.c:   *state = !!(*state && (led->strobing_sub_led_id == sub_led->fled_id));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(mfw_val == DCBX_APP_SF_IEEE_ETHTYPE);
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(mfw_val == type || mfw_val == DCBX_APP_SF_IEEE_TCP_UDP_PORT);
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(ethtype && (proto_id == QED_ETH_TYPE_DEFAULT));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(port && (proto_id == QED_TCP_PORT_ISCSI));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(ethtype && (proto_id == QED_ETH_TYPE_FCOE));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(ethtype && (proto_id == QED_ETH_TYPE_ROCE));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     return !!(port && (proto_id == QED_UDP_PORT_TYPE_ROCE_V2));
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     ethtype = !!(idtype == DCB_APP_IDTYPE_ETHTYPE);
drivers/net/ethernet/qlogic/qed/qed_dcbx.c:     ethtype = !!(idtype == DCB_APP_IDTYPE_ETHTYPE);
drivers/net/wireless/ath/ath9k/recv.c:  is_40 = !!(rxs->bw == RATE_INFO_BW_40);
drivers/pci/controller/pcie-iproc.c:    return !!(reg_offset == IPROC_PCIE_REG_INVALID);
drivers/pci/controller/pcie-iproc.c:    return !!(ib_map->type == type);
drivers/pci/hotplug/pnv_php.c:          added = !!(presence == OPAL_PCI_SLOT_PRESENT);
drivers/platform/x86/asus-wmi.c:                ctrl_param = !!(bd->props.power == FB_BLANK_UNBLANK);
drivers/scsi/hisi_sas/hisi_sas_main.c:          bool do_port_check = !!(_sas_port != sas_port);
fs/ocfs2/reservations.c:        return !!(resv->r_len == 0);
fs/ubifs/journal.c:     int last_reference = !!(deletion && inode->i_nlink == 0);
fs/ubifs/journal.c:     int last_reference = !!(new_inode && new_inode->i_nlink == 0);
sound/firewire/amdtp-stream.c:          !!(params->header_length == 0 && params->payload_length == 0);
tools/perf/util/time-utils.c:           num += !!(*cp == ',');



