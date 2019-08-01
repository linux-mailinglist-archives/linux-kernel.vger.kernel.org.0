Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423357D5A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfHAGmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:42:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64619 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbfHAGmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:42:49 -0400
X-UUID: 5eea4bb1b2494c0cabbd928d4ab8c7ad-20190801
X-UUID: 5eea4bb1b2494c0cabbd928d4ab8c7ad-20190801
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1889210897; Thu, 01 Aug 2019 14:42:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 1 Aug 2019 14:42:42 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 1 Aug 2019 14:42:42 +0800
Message-ID: <1564641762.26186.1.camel@mtkswgap22>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>
Date:   Thu, 1 Aug 2019 14:42:42 +0800
In-Reply-To: <20190801163948.7c869a34@canb.auug.org.au>
References: <20190731161151.26ef081e@canb.auug.org.au>
         <1564554484.28000.3.camel@mtkswgap22>
         <20190801155130.29a07b1b@canb.auug.org.au>
         <20190801061527.GB11627@dhcp22.suse.cz>
                <1564641003.25219.7.camel@mtkswgap22>
         <20190801163948.7c869a34@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 16:39 +1000, Stephen Rothwell wrote:
> Hi Miles,
> 
> On Thu, 1 Aug 2019 14:30:03 +0800 Miles Chen <miles.chen@mediatek.com> wrote:
> >
> > It's the first time that I receive a build warning after the patch has
> > been merged to -mm tree. The build warning had been fixed by Qian,
> > should I send another change for this?
> 
> No, that will do.

got it. thanks

