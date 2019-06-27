Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858BA5827C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfF0MYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 08:24:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfF0MYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:24:23 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgTRs-00026w-11; Thu, 27 Jun 2019 14:24:20 +0200
Date:   Thu, 27 Jun 2019 14:24:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH v2 0/7] misc fixes to PV extentions code
In-Reply-To: <ab80e007-1d7e-ff13-d11a-10999d198ad3@oracle.com>
Message-ID: <alpine.DEB.2.21.1906271423310.32342@nanos.tec.linutronix.de>
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com> <alpine.DEB.2.21.1906261511180.32342@nanos.tec.linutronix.de> <ab80e007-1d7e-ff13-d11a-10999d198ad3@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1429891856-1561638260=:32342"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1429891856-1561638260=:32342
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Zhenzhong,

On Thu, 27 Jun 2019, Zhenzhong Duan wrote:
> On 2019/6/26 21:39, Thomas Gleixner wrote:
> > Documentation/process/submitting-patches.rst clearly explains why it is a
> > bad idea to send random collections of patches especially if some patches
> > are independent and contain bug fixes.
> > 
> > These rules exist for a reason and are not subject to personal
> > interpretation. You want your patches to be reviewed and merged, so pretty
> > please make the life of those who need to do that as easy as possible.
> > 
> > It's not the job of reviewers and maintainers to distangle your randomly
> > ordered patch series.
> 
> Ok，understood.  I'll send independent and unrelated patch seperately.

Much appreciated.

Thanks,

	tglx
--8323329-1429891856-1561638260=:32342--
