Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99DC8ECC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbfHON1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 09:27:32 -0400
Received: from verein.lst.de ([213.95.11.211]:46701 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfHON1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:27:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A98968AFE; Thu, 15 Aug 2019 15:27:28 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:27:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Richard Kuo <rkuo@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: drop empty and unused free_initrd_mem
Message-ID: <20190815132728.GB12036@lst.de>
References: <1565858133-25852-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565858133-25852-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:35:33AM +0300, Mike Rapoport wrote:
> hexagon never reserves or initializes initrd and the only mention of it is
> the empty free_initrd_mem() function.
> 
> As we have a generic implementation of free_initrd_mem(), there is no need
> to define an empty stub for the hexagon implementation and it can be
> dropped.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
