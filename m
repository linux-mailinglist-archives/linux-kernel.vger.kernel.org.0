Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897275E2C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGCLWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 07:22:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:14283 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726255AbfGCLWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:22:42 -0400
X-UUID: 22bec9af9d5e4b6bae6d07223e81147f-20190703
X-UUID: 22bec9af9d5e4b6bae6d07223e81147f-20190703
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1647223127; Wed, 03 Jul 2019 19:22:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Jul 2019 19:22:30 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Jul 2019 19:22:30 +0800
Message-ID: <1562152950.25531.4.camel@mtkswgap22>
Subject: Re: [PATCH] checkpatch: avoid default n
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joe Perches <joe@perches.com>
CC:     Andy Whitcroft <apw@canonical.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 3 Jul 2019 19:22:30 +0800
In-Reply-To: <be8a97c15249ff8a613910db5792c5bcdc75333c.camel@perches.com>
References: <20190703083031.2950-1-miles.chen@mediatek.com>
         <be8a97c15249ff8a613910db5792c5bcdc75333c.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 01:42 -0700, Joe Perches wrote:
> On Wed, 2019-07-03 at 16:30 +0800, Miles Chen wrote:
> > This change reports a warning when "default n" is used.
> > 
> > I have seen several "remove default n" patches, so I think
> > it might be helpful to add this test in checkpatch.
> > 
> > tested:
> > WARNING: 'default n' is the default value, no need to write it explicitly.
> > +       default n
> 
> I don't think this is reasonable as there are
> several uses like:
> 
> 		default y
> 		default n if <foo>
> 
> For instance:
> 
> arch/alpha/Kconfig-config ALPHA_WTINT
> arch/alpha/Kconfig-     bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
> arch/alpha/Kconfig-     default y if ALPHA_QEMU
> arch/alpha/Kconfig:     default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
> arch/alpha/Kconfig:     default n if !ALPHA_SRM && !ALPHA_GENERIC
> 
> 
Thanks for your comment, perhaps we can just deal with the "default n$"
case?

like:
+         $line =~ /^\+\s*\bdefault n$/) {


