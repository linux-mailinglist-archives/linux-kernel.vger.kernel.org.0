Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25B685A2B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 08:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfHHGBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 02:01:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65088 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbfHHGBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:01:21 -0400
X-UUID: 15d60b0f7b4e48ddab55782eec9a1a68-20190808
X-UUID: 15d60b0f7b4e48ddab55782eec9a1a68-20190808
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1773491286; Thu, 08 Aug 2019 14:01:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 8 Aug 2019 14:01:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 8 Aug 2019 14:01:15 +0800
Message-ID: <1565244075.26350.3.camel@mtkswgap22>
Subject: Re: [PATCH v2] arm64: mm: print hexadecimal EC value in
 mem_abort_decode()
From:   Miles Chen <miles.chen@mediatek.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Mark Rutland <Mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>
Date:   Thu, 8 Aug 2019 14:01:15 +0800
In-Reply-To: <98bdbcfb-24ed-fcd8-4b2c-f2c78b245dda@arm.com>
References: <20190807003336.28040-1-miles.chen@mediatek.com>
         <98bdbcfb-24ed-fcd8-4b2c-f2c78b245dda@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 11:19 +0530, Anshuman Khandual wrote:
> 
> On 08/07/2019 06:03 AM, Miles Chen wrote:
> > This change prints the hexadecimal EC value in mem_abort_decode(),
> > which makes it easier to lookup the corresponding EC in
> > the ARM Architecture Reference Manual.
> > 
> > The commit 1f9b8936f36f ("arm64: Decode information from ESR upon mem
> > faults") prints useful information when memory abort occurs. It would
> > be easier to lookup "0x25" instead of "DABT" in the document. Then we
> > can check the corresponding ISS.
> > 
> > For example:
> > Current	info	  	Document
> > 		  	EC	Exception class
> > "CP15 MCR/MRC"		0x3	"MCR or MRC access to CP15a..."
> > "ASIMD"			0x7	"Access to SIMD or floating-point..."
> > "DABT (current EL)" 	0x25	"Data Abort taken without..."
> > ...
> > 
> > Before:
> > Unable to handle kernel paging request at virtual address 000000000000c000
> > Mem abort info:
> >   ESR = 0x96000046
> >   Exception class = DABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> > Data abort info:
> >   ISV = 0, ISS = 0x00000046
> >   CM = 0, WnR = 1
> > 
> > After:
> > Unable to handle kernel paging request at virtual address 000000000000c000
> > Mem abort info:
> >   ESR = 0x96000046
> >   EC = 0x25: DABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> > Data abort info:
> >   ISV = 0, ISS = 0x00000046
> >   CM = 0, WnR = 1
> > 
> > Change since v1:
> > print "EC" instead of "Exception class"
> > print EC in fixwidth
> > 
> > Cc: Mark Rutland <Mark.rutland@arm.com>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> This version implements the suggestion, hence it should have
> also contained acked-by tag from Mark from earlier version.
> 

No problem. Sorry for not including the tag.
I was not sure if I should add the acked-by tag from Mark in patch v2.

> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

If I send patch v3, I should include acked-by tag from Mark and
Reviewed-by tag from you, right?


Miles

