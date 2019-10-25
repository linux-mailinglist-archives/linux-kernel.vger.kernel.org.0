Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6224E5750
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 01:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfJYX6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 19:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfJYX6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:58:04 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20566206E0;
        Fri, 25 Oct 2019 23:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572047883;
        bh=DCSLD8b6nF368+9qOsao2twIZ3wvvVlpSF9QZ0Md0Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsS9jvaRIXmkq970vIkLXE0MAgl4P5paKvsO7iQGVQg4apc2nQ5zFE2nW8FB5HhiZ
         8yD25obdWEefEWfGgUhE61MweSDrkSA+m1oLyadmJHj78ZrBEQY6holnabH67mf9lY
         d+e7HNAGGjEc2HLDapWHBTPdrobse/U1sTAneeio=
Date:   Sat, 26 Oct 2019 08:58:00 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH] nvmet: Cleanup nvmet_req_init() branching
Message-ID: <20191025235800.GB23826@redsun51.ssa.fujisawa.hgst.com>
References: <20191025193739.9878-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025193739.9878-1-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 01:37:39PM -0600, Logan Gunthorpe wrote:
> This is a prep patch for the nvmet passthru patch set. It was part
> of Christoph's feedback.

Looks like he sent the same patch just ahead of this one.
