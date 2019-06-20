Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53944C9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 10:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfFTIvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 04:51:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:26294 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfFTIvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:51:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 01:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="243567007"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2019 01:51:04 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: dwc3: remove unused @lock member of dwc3_ep struct
In-Reply-To: <1561019039.19385.0.camel@mhfsdcap03>
References: <342af01a252a9ef9457a6a6ec653a40698058fbc.1561018149.git.chunfeng.yun@mediatek.com> <87pnn8brej.fsf@linux.intel.com> <1561019039.19385.0.camel@mhfsdcap03>
Date:   Thu, 20 Jun 2019 11:51:04 +0300
Message-ID: <87muicbpxj.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> Hi,
> On Thu, 2019-06-20 at 11:19 +0300, Felipe Balbi wrote:
>> Hi,
>> 
>> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
>> 
>> > The member @lock of dwc2_ep struct is only initialized,
>> > and not used elsewhere, so remove it.
> Sorry, I need send v2 to fix typo of dwc2_ep

I fixed when applying ;-)

-- 
balbi
