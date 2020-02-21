Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5308167FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 15:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgBUON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 09:13:58 -0500
Received: from verein.lst.de ([213.95.11.211]:55640 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgBUON6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:13:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0097268BFE; Fri, 21 Feb 2020 15:13:54 +0100 (CET)
Date:   Fri, 21 Feb 2020 15:13:54 +0100
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
Subject: Re: [PATCH 2/3] samples/hw_breakpoint: Drop use of
 kallsyms_lookup_name()
Message-ID: <20200221141354.GC6968@lst.de>
References: <20200221114404.14641-1-will@kernel.org> <20200221114404.14641-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221114404.14641-3-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:44:03AM +0000, Will Deacon wrote:
> -static char ksym_name[KSYM_NAME_LEN] = "pid_max";
> +static char ksym_name[KSYM_NAME_LEN] = "jiffies";

Is jiffies actually an exported symbol on all configfs?  I thought
there was some weird aliasing going on with jiffies64.

Except for the symbol choice this looks fine, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>
