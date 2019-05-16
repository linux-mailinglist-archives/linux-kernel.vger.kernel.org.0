Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B211920E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfEPRhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 13:37:54 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:39996 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbfEPRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:37:54 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 29261C0BC3;
        Thu, 16 May 2019 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558028263; bh=Wmy4EGULNayDPs5gXSLg4GnxB4UoMyTMnJFypw/UAMs=;
        h=From:To:CC:Subject:Date:References:From;
        b=RFo89LUgrQVhapH4tg0LTkHnYmSWx/0iOcJhA1/wNiAqNlq2G0BcoBqBQ094mISSm
         sUJNK2Mu9R/qVLHOM4oag6F34iE9EbuUVXrqaLIT+lVPLHCmB7al/P92uaisSvB4Bu
         zOGPkf4va32BVku1mILHhQEYqe6wd1V0b1bJ1La3c3iWJFe3VH1WUfzI4UUsWGzGbL
         MpN5Bb1Q7zEq6IsqtkgA8E+mLs9zKTz4xMQ9GGnwti40hCpmIe5EwPViiGeV378wC+
         KMAN1mcDI6C/1vg2v4ib8pbEAKJUvXi2inpNw9CGudQuJi37F/g62dqVkUheaDkL3e
         Tm/X0X86XhJJA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 744EEA006A;
        Thu, 16 May 2019 17:37:52 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Thu, 16 May 2019 10:37:52 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "paltsev@snyopsys.com" <paltsev@snyopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma
 access permission code
Thread-Topic: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma
 access permission code
Thread-Index: AQHVCrVZlKJI28iPlEu8hsRog7Qd0g==
Date:   Thu, 16 May 2019 17:37:51 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2517B16@us01wembx1.internal.synopsys.com>
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
 <1557880176-24964-5-git-send-email-vgupta@synopsys.com>
 <1558027448.2682.11.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/19 10:24 AM, Eugeniy Paltsev wrote:=0A=
>> +	unsigned int write =3D 0, exec =3D 0, mask;=0A=
> Probably it's better to use 'bool' type for 'write' and 'exec' as we real=
ly use them as a boolean variables.=0A=
=0A=
Right those are semantics, but the generated code for "bool" is not ideal -=
 given=0A=
it is inherently a "char" it is promoted first to an int with an additional=
 EXTB=0A=
which I really dislike.=0A=
Guess it is more of a style thing.=0A=
=0A=
-Vineet=0A=
