Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6BA167CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBULxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 06:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgBULxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:53:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C15208C4;
        Fri, 21 Feb 2020 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285986;
        bh=IuAmYb7MC/2fejAZ6a0eR2/GE2OMz+gIiQ+fmN6YnIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iO05qof27ZPw7Jb/9oksMPMn27j2cOJ1/AohmaYwE03FpdDejMIXWZs1QL5eX/EgK
         RyrybzimBe8PYVqOUiOzpVqS0j8boQmVv912MUk36jhLmR1ufDXviyJluOiv03m6Vz
         QPPE/06V9gC/GBl/Qf+0fNGSWX1DfMv1umRXeMK0=
Date:   Fri, 21 Feb 2020 12:53:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] kallsyms: Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-ID: <20200221115303.GB116368@kroah.com>
References: <20200221114404.14641-1-will@kernel.org>
 <20200221114404.14641-4-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221114404.14641-4-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:44:04AM +0000, Will Deacon wrote:
> kallsyms_lookup_name() and kallsyms_on_each_symbol() are exported to
> modules despite having no in-tree users and being wide open to abuse by
> out-of-tree modules that can use them as a method to invoke arbitrary
> non-exported kernel functions.
> 
> Unexport kallsyms_lookup_name() and kallsyms_on_each_symbol().
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
