Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCEF8A87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 09:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKLIcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 03:32:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfKLIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PnZ2Xv5QzU531/DlEw36PKsM1WpetiqrlbT9IG3dL8k=; b=lZgfxhZyE0dP0kDFJj9ftdq3e
        yq8njdAiJAJmROqgXXkjeet9Kq0VPAvIgJiknDR8CFlDh65AYeRy4/DWFKszRy5UZvB+NVTkxFawx
        gt7svXxxKHexXgxjyIWB2hiDL7DFwkmm4g0Jk7KQrySSF5ZhK1G67qeJBQ5/cvZ4HDJ2o5qFUye28
        E8X7WbWG1gWSWYAB/gzK5+dNVZsyE5JmXRiGkXEdxB7qCWan9PaQaO9vIjJz/xkb4Vz44vpqY3+4O
        QVkGADHTKd/G7ObvDP/VTZiUZ56B4RnVWkwZr74pytebO/unRAAsmSRv8Fq+FxeupcziqAT8pJVj5
        aDwz1CXFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iURaq-0001FL-To; Tue, 12 Nov 2019 08:32:08 +0000
Date:   Tue, 12 Nov 2019 00:32:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] loop: Report EOPNOTSUPP properly
Message-ID: <20191112083208.GA1848@infradead.org>
References: <20191111185030.215451-1-evgreen@chromium.org>
 <20191111185030.215451-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111185030.215451-2-evgreen@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:50:29AM -0800, Evan Green wrote:
> -		if (cmd->ret < 0)
> +		if (cmd->ret == -EOPNOTSUPP)
> +			ret = BLK_STS_NOTSUPP;
> +		else if (cmd->ret < 0)
>  			ret = BLK_STS_IOERR;

This really should use errno_to_blk_status.  Same for the other hunk.
