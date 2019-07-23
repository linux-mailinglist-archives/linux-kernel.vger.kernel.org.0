Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB4571C16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbfGWPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:47:50 -0400
Received: from verein.lst.de ([213.95.11.211]:42843 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfGWPru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:47:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D337168B02; Tue, 23 Jul 2019 17:47:48 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:47:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>
Subject: Re: [PATCH v3] nvme: fix multipath crash when ANA deactivated
Message-ID: <20190723154748.GB1331@lst.de>
References: <504897239.41425939.1563860480394.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504897239.41425939.1563860480394.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.3.
