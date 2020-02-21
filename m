Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66115167FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgBUOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 09:12:32 -0500
Received: from verein.lst.de ([213.95.11.211]:55627 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgBUOMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:12:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4B6668C65; Fri, 21 Feb 2020 15:12:28 +0100 (CET)
Date:   Fri, 21 Feb 2020 15:12:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/3] samples/hw_breakpoint: Drop HW_BREAKPOINT_R when
 reporting writes
Message-ID: <20200221141228.GB6968@lst.de>
References: <20200221114404.14641-1-will@kernel.org> <20200221114404.14641-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221114404.14641-2-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:44:02AM +0000, Will Deacon wrote:
> Given the name of a kernel symbol, the 'data_breakpoint' test claims to
> "report any write operations on the kernel symbol". However, it creates
> the breakpoint using both HW_BREAKPOINT_W and HW_BREAKPOINT_R, which
> menas it also fires for read access.
> 
> Drop HW_BREAKPOINT_R from the breakpoint attributes.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
