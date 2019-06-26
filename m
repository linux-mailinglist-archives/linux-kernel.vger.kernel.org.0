Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A65B5636E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfFZHfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 03:35:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lDmlG4QlTTriJzFXWbGaRSBBFeeq9DSPhk5L2uu/dys=; b=FEIrxw0fA7wZ2Dgvq5SBxdVmN
        yhPyT0gCj6Bxbl/m8JShCPjIBGhfUFMREoijyGu6CGikjCKKCpf0b2qqwRam7jR/hlWuYyDPM14ds
        bqUfT5iAeCLEabNpYahNp1jcOmxfA6iSmh2JpyOpAGQyjm/PM5Ydk9rf9HcVKqWWmuf4OJHVZc+6D
        rl69Hx7yZb+nynPThSA+wG+PtBSuSdLyPqJw9ARsh/w+6FRPip840hneIcWRmm0HUdymEGBFaMQnZ
        LldmT8tVf34HugoPD5imjld6/n5Hh1p8tAsqrTrCSR7iV3Rjlzy3Ea9+xB76jwxTfsxNP6/h0qr0F
        y1s4FQJ5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hg2Sr-0007dW-2T; Wed, 26 Jun 2019 07:35:33 +0000
Date:   Wed, 26 Jun 2019 00:35:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Message-ID: <20190626073533.GA24199@infradead.org>
References: <cover.1558547956.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558547956.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin, Andrew:

I have a series for the hmm tree, which touches the section size
bits, and remove device public memory support.

It might be best if we include this series in the hmm tree as well
to avoid conflicts.  Is it ok to include the rebase version of at least
the cleanup part (which looks like it is not required for the actual
arm64 support) in the hmm tree to avoid conflicts?
