Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA571077CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 20:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKVTHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 14:07:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfKVTHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qiY03cWkKvWU8uOxj3HAT7UHKA03ikQ/FO2WIvS4EWw=; b=HDPXvtPMmErfbxSjo4gpGLhFO
        AKXfAQJ4M1Mdd//OfGFHdmLefRtXxrKQ5rKbLSZ8JZ2f7Kswj4JlwbdQdFBQtu7BnlL/vm9gGkQT+
        KaKkNX+9WhX7ugGxgPQLPOm9iW/xbtZYtWczgJgbMZxQ7cJlFRRrGnH7OqEKp0eYcnIaEAYEUURm2
        40AlNUX9b101r0F8itT5mgBh+HB/Jht5kTS/wKUkny6kSSDWtKDt7g0mhL+DZnRZiFhVgezSrHSSV
        3MEv1vxDpWLAXrWKr8O6H6zFiFr7C+rg8Xb+lztSKH0llurL8+2PqwfCOMq62cwX91HEQ66rgCtni
        YuyDbGV0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYEGp-0000a5-5q; Fri, 22 Nov 2019 19:07:07 +0000
Date:   Fri, 22 Nov 2019 11:07:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
Message-ID: <20191122190707.GA2136@infradead.org>
References: <20180824211535.GA22251@beast>
 <201911221052.0FDE1A1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911221052.0FDE1A1@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:53:22AM -0800, Kees Cook wrote:
> Friendly ping! I keep tripping over this. Can this please get applied so
> we can silence syzbot and avoid needless WARNs? :)

What call stack reaches this?  Upper layers should never submit a write
bio on a read-only queue, and we need to fix that in the upper layer.
