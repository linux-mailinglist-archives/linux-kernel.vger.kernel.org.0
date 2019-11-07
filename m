Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80364F3600
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbfKGRoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 12:44:10 -0500
Received: from verein.lst.de ([213.95.11.211]:58608 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729830AbfKGRoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:44:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 136F668BE1; Thu,  7 Nov 2019 18:44:09 +0100 (CET)
Date:   Thu, 7 Nov 2019 18:44:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH dma-debug: reorder struct dma_debug_entry fields
Message-ID: <20191107174408.GB19858@lst.de>
References: <20191030193204.133327-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030193204.133327-1-edumazet@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree for 5.5.
