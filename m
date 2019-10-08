Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973C0CFF8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJHRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 13:07:54 -0400
Received: from utopia.booyaka.com ([74.50.51.50]:60682 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfJHRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:07:53 -0400
Received: (qmail 6504 invoked by uid 1019); 8 Oct 2019 17:07:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Oct 2019 17:07:52 -0000
Date:   Tue, 8 Oct 2019 17:07:52 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 4/4] riscv: remove the switch statement in
 do_trap_break()
In-Reply-To: <CABvJ_xiHJSB7P5QekuLRP=LBPzXXghAfuUpPUYb=a_HbnOQ6BA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.999.1910081707220.4786@utopia.booyaka.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com> <1569199517-5884-5-git-send-email-vincent.chen@sifive.com> <20190927224711.GI4700@infradead.org> <alpine.DEB.2.21.9999.1910070906570.10936@viisi.sifive.com> <20191007161050.GA20596@infradead.org>
 <alpine.DEB.2.21.9999.1910070930270.10936@viisi.sifive.com> <CABvJ_xiHJSB7P5QekuLRP=LBPzXXghAfuUpPUYb=a_HbnOQ6BA@mail.gmail.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019, Vincent Chen wrote:

> Sorry,  I missed the comment. Christoph's suggestion is also good to me.
> I will modify it as you suggested.

Thanks - no need to resend, I'll queue the modified patch up here.


- Paul
