Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B09324873
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 08:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfEUGyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 02:54:09 -0400
Received: from verein.lst.de ([213.95.11.211]:57794 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfEUGyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:54:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2BBDE68B05; Tue, 21 May 2019 08:53:47 +0200 (CEST)
Date:   Tue, 21 May 2019 08:53:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     xiaolinkui <xiaolinkui@kylinos.cn>
Cc:     hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: target: use struct_size() in kmalloc()
Message-ID: <20190521065346.GG30402@lst.de>
References: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok to me, although for a fixed size argument the whole overflow
detection thing in struct_size() is rather pointless..

