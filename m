Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B54E7BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 22:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfJ1VzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 17:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbfJ1VzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:55:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44B821479;
        Mon, 28 Oct 2019 21:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572299716;
        bh=Rc95UNWyxGNZm3HxfC9xIsJjTnLTSIuz9wUtAFykboU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHFCPZDBqR5Z8FzqCKu6QIEzbXI8bIcVg41IW5SWRRLue8d6vpsqlJlicuWXCK0Xc
         CDMoSbAfrAx1Sd5Ib6KsblBiqBCCYnBk/jdOEUDvJxU+Of44Cu8POhYgKslXOFpS5T
         rdta4Ep8cCxOgSYm8C0CBTcdYnVAmlGjr0uiArMY=
Date:   Mon, 28 Oct 2019 21:55:11 +0000
From:   Will Deacon <will@kernel.org>
To:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH v6 0/2] Add CCPI2 PMU support
Message-ID: <20191028215510.GA8532@willie-the-truck>
References: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:36:57AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> Add Cavium Coherent Processor Interconnect (CCPI2) PMU
> support in ThunderX2 Uncore driver.
> 
> v6:
> 	Rebased to 5.4-rc1

Thanks, this looks good to me so I'll queue it up for 5.5.

Will
