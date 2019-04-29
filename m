Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C2EBAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfD2Ucw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 16:32:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfD2Ucw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HHV9M9JNH9wJqqd1pXtgGONHUqdV+e8U142riGFNVzI=; b=IQH8qytmmguUYLg411iGVKfNN
        nD34eKEWYiRYhLBhMUx+mqr5lv6zDoFm5cgrOopbYOwpGHYUs4cFHxqZrbBT4+rXBEufDz606/4KN
        ZRtQ7vs2ld14WHx/mERkN5Z3GfhnAQkYpngTf84Ej7zV6Mzc5ghyfvn/z+qfmtOKAVs0Tjk6yxZGN
        MdZ6OeWTiXY5OuQU3h7GLXeljG9ZAnJ26lymJ8p2EevkaoW4wvwto6It4Q3qVbjSFX9YBAaURjMj0
        tcogCFCNcCflZZDzzRSopRlcopa2lLAIkTX8zDhHQ0FbHr9PxGOqKbyQNTFMrzPxaOQxxIlYulAum
        C1GQrJ1dQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLCx3-0006UU-RG; Mon, 29 Apr 2019 20:32:37 +0000
Date:   Mon, 29 Apr 2019 13:32:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] fdomain: Resurrect driver (core)
Message-ID: <20190429203237.GA19699@infradead.org>
References: <20190428200626.28092-1-linux@zary.sk>
 <20190428200626.28092-2-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428200626.28092-2-linux@zary.sk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +void fdomain_reset(int base)

Should be marked static.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
