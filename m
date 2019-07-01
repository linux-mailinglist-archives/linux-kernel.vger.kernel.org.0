Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0E13A75
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfEDNxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 09:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfEDNxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 09:53:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F0E20645;
        Sat,  4 May 2019 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556977993;
        bh=uQ3EHPM6nWaIj9WjuKyw59nDro9YwEPYOtjiLFpZT4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sABDdkAYNbfpRzn68AYk+T255p6rM+RSwyvNYewANvNXPOrhE1EcUQqsCHOaSO9Lh
         OMR09dMnYTKvy8oSp84qkIWytvw0YtJ149JN1E1t9IQ/feCGPD/8fc7VCzhKgW21KT
         G7N49lAxy25tek3QXLLgdXElQrjJ/edgZda418bM=
Date:   Sat, 4 May 2019 15:53:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 8/8] perf/x86: Use update attribute groups for default
 attributes
Message-ID: <20190504135310.GA6989@kroah.com>
References: <20190504125207.24662-1-jolsa@kernel.org>
 <20190504125207.24662-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504125207.24662-9-jolsa@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 02:52:07PM +0200, Jiri Olsa wrote:
> Using the new pmu::update_attrs attribute group for default
> attributes - freeze_on_smi, allow_tsx_force_abort.

"And delete the unused merge_attr() function"

Nice work with this series, it looks sane to me!

greg k-h
