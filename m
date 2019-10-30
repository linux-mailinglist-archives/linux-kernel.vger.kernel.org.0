Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F3EA313
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 19:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfJ3SMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 14:12:22 -0400
Received: from verein.lst.de ([213.95.11.211]:47124 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJ3SMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:12:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C16EC68C4E; Wed, 30 Oct 2019 19:12:20 +0100 (CET)
Date:   Wed, 30 Oct 2019 19:12:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] dma-debug: add a schedule point in
 debug_dma_dump_mappings()
Message-ID: <20191030181220.GB19513@lst.de>
References: <20191028215646.16638-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028215646.16638-1-edumazet@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping for-next tree.
