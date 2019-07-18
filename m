Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31E6C8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 07:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfGRFsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 01:48:53 -0400
Received: from verein.lst.de ([213.95.11.211]:56624 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfGRFsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:48:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74C6E68AFE; Thu, 18 Jul 2019 07:48:51 +0200 (CEST)
Date:   Thu, 18 Jul 2019 07:48:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: RFC: move kernel/memremap.c to mm/
Message-ID: <20190718054851.GA18376@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

was there any really good reason to have memremap.c in kernel/ back
when you started it?  It seems to be pretty much tried into the mm
infrastructure, and I keep mistyping the path.  Would you mind a simple
git-mv patch after -rc1 to move it to mm/ ?
