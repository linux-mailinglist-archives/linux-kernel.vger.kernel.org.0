Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A216F93B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgBZIK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgBZIKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE2A24650;
        Wed, 26 Feb 2020 08:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582704651;
        bh=b4WNO08j3CpteKtJyCgXEieJzjysEvoALEM8S6HNPII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAQDAQNjQtfWzSk5WI9lp4qS6LFd8fSlh4NLanUuVcD45OWhPPEXh6oht7DP7wOjR
         XjMh7+dmN6id5qBuy0UXkBwdeXj52eqMndxpPxBM2IUCkoNBZY2/aIBRs+6ZJkDkTH
         Tkn6q91v45WwXRAsD1xM/c0BNxNsXtM75v7vOocs=
Date:   Wed, 26 Feb 2020 09:10:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, naveen.n.rao@linux.ibm.com,
        changbin.du@intel.com, ardb@kernel.org, rizzo@iet.unipi.it,
        pabeni@redhat.com, toke@redhat.com, hawk@kernel.org
Subject: Re: [PATCH 0/2] quickstats, kernel sample collector
Message-ID: <20200226081048.GC22801@kroah.com>
References: <20200226023027.218365-1-lrizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226023027.218365-1-lrizzo@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:30:25PM -0800, Luigi Rizzo wrote:
> This patchset introduces a small library to collect per-cpu samples and
> accumulate distributions to be exported through debugfs.

Shouldn't this be part of the tracing infrastructure instead of being
"stand-alone"?

thanks,

greg k-h
