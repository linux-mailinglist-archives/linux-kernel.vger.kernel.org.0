Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9384C9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfFTIyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 04:54:50 -0400
Received: from verein.lst.de ([213.95.11.211]:58766 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731681AbfFTIyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:54:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 371D768B20; Thu, 20 Jun 2019 10:54:17 +0200 (CEST)
Date:   Thu, 20 Jun 2019 10:54:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RESEND PATCH] block: move tag field position in struct request
Message-ID: <20190620085416.GB23140@lst.de>
References: <20190608201551.4531-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608201551.4531-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
