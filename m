Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3193F1134
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 09:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfKFIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 03:37:15 -0500
Received: from verein.lst.de ([213.95.11.211]:49969 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbfKFIhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:37:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 53EFA68BE1; Wed,  6 Nov 2019 09:37:12 +0100 (CET)
Date:   Wed, 6 Nov 2019 09:37:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Philippe Liard <pliard@google.com>
Cc:     phillip@squashfs.org.uk, hch@lst.de, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Subject: Re: [PATCH v3] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191106083711.GB10679@lst.de>
References: <20191106074238.186023-1-pliard@google.com> <20191106083423.GA10679@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106083423.GA10679@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the empty reply.

This was meant to say that the patch looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
