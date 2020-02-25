Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BDA16C156
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgBYMur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 07:50:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42098 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgBYMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g+KiJZzksPAm2BNWFU7kxrgNyJwR+BQ4nqNwddviLwE=; b=tCh9n7eE375VlDUXXbMfRxeU5t
        BODlcDvyopq6h4o8ADOabjBwl7+bM+eJDXxDiW9VvedM9hC+hhDR8qYMl1keKDi8aOxnDPSuF27NY
        GznS6JGLmDAD4U6yc24GcNOVuHXJNnD6QVRG3qjsXUvqJRiP3rwffnHdw1Pzmw+UOL85eLw2Hq2pe
        jUPVZNiuXo6YJF4MYXEW3LPe69DbOgp9BaXmtG4iNTEeuyj5bH06fMKY9d0McLrhyQmm6L5Kx9JLE
        236w/SOd0/8NpFPIdNFW0/QT3n1qTaGPpIS1yhp3cfb2rJDtzjegTQdk9w1J7WO7WIuvrcpsiXzDM
        xsLsJHvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6ZfW-0003gq-6w; Tue, 25 Feb 2020 12:50:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67198306060;
        Tue, 25 Feb 2020 13:48:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FDD82B4DAAF6; Tue, 25 Feb 2020 13:50:30 +0100 (CET)
Date:   Tue, 25 Feb 2020 13:50:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        dan.j.williams@intel.com
Subject: Re: [PATCH v5 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200225125030.GL18400@hirez.programming.kicks-ass.net>
References: <20200224225020.2212544-1-jesse.brandeburg@intel.com>
 <20200225103050.GD10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225103050.GD10400@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:30:50PM +0200, Andy Shevchenko wrote:

> I think it is a C standard which dictates this, compiler just follows.

Correct, a semi readable explanation of this:

  https://stackoverflow.com/questions/46073295/implicit-type-promotion-rules
