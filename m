Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C773ACBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 03:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfFJBu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 21:50:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:64539 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729954AbfFJBu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 21:50:28 -0400
X-UUID: a4426e538ff749c7a00a11ca68c610d1-20190610
X-UUID: a4426e538ff749c7a00a11ca68c610d1-20190610
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1004482231; Mon, 10 Jun 2019 09:50:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Jun
 2019 09:50:11 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 09:50:09 +0800
Message-ID: <1560131408.8487.112.camel@mhfsdcap03>
Subject: Re: [PATCH v6 06/10] device connection: Add
 fwnode_connection_find_match()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Date:   Mon, 10 Jun 2019 09:50:08 +0800
In-Reply-To: <20190607103026.GE10298@kuha.fi.intel.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
         <1559115828-19146-7-git-send-email-chunfeng.yun@mediatek.com>
         <20190607103026.GE10298@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Fri, 2019-06-07 at 13:30 +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Wed, May 29, 2019 at 03:43:44PM +0800, Chunfeng Yun wrote:
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > The fwnode_connection_find_match() function is exactly the
> > same as device_connection_find_match(), except it takes
> > struct fwnode_handle as parameter instead of struct device.
> > That allows locating device connections before the device
> > entries have been created.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This one is also missing your SoB.
> 
> There are now some other changes to the devcon API in Rafael's tree
> [1] that will conflict with this one. I'm attaching a modified version
> of the patch that is rebased on top of today's linux-next. If you use
> it, you should make a note (probable in the cover letter) that the
> series now depends on Rafael's tree.
Got it, thanks

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next
> 
> 
> thanks,
> 


