Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B07DA456
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407578AbfJQD1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 23:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732869AbfJQD1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:27:01 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699EC20640;
        Thu, 17 Oct 2019 03:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571282821;
        bh=XvBeg7TzhsqdaOPxVpJmWL2oonJbx2FFN9cGwYruGQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qoTsYbcs/HLjh7anCCftNRsW8YVQ03EeYfp635WLn/ka7G15TJOANN23/4lcSj+ev
         r8DYbxdQftGy84Gu77XbREd3T6sT6eDgBw4XHQ56QCFCZ36rqpQj/k/UCuV4a3ECh5
         gY4S1RWgElkUHJaAKIqmC+vOZyA/vz0djXCgfdT4=
Date:   Thu, 17 Oct 2019 12:26:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v4 0/4] x86: kprobes: Prohibit kprobes on Xen/KVM
 emulate prefixes
Message-Id: <20191017122655.6fae3c0e44417a0af30cd2d1@kernel.org>
In-Reply-To: <20191009123106.GK2311@hirez.programming.kicks-ass.net>
References: <156777561745.25081.1205321122446165328.stgit@devnote2>
        <20190917151403.60023814bda80304777a35e5@kernel.org>
        <20191009123106.GK2311@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, 9 Oct 2019 14:31:06 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Sep 17, 2019 at 03:14:03PM +0900, Masami Hiramatsu wrote:
> > Hi Peter,
> > 
> > Could you review this version?
> 
> These look good to me; shall I merge them or what was the plan?

Thanks for the review, yes, could you merge this series to support emulated prefixes correctly?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
