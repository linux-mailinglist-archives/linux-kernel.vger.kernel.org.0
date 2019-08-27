Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05BD9F186
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfH0RZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfH0RZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:25:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8377A20679;
        Tue, 27 Aug 2019 17:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566926722;
        bh=K/OrNZ1/NkG8w//ts4b2cbgqqyZMD7w/w/VddjKznq8=;
        h=Date:From:To:Cc:Subject:From;
        b=2Md4vLXa1nt2CEOWtH42unvsgzFIIuRwYIboeiUVIbnyml+Rmu/TGtbdC28ZSDNOw
         E8MavBKWWnyNIfPsC78gK4kOpjYOQSTjutej5ASFYCXfjFwGvQAk41p2lF63e5kPnE
         jegq/Mziolkf+lc9vmRN2ptImVxvHEHOh/ai0bHw=
Date:   Tue, 27 Aug 2019 19:25:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-spdx@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add entry for LICENSES and SPDX stuff
Message-ID: <20190827172519.GA28849@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas and I seem to have become the "unofficial" maintainers for these
files and questions about SPDX things.  So let's make it official.

Reported-by: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9234,6 +9234,17 @@ F:	include/linux/nd.h
 F:	include/linux/libnvdimm.h
 F:	include/uapi/linux/ndctl.h
 
+LICENSES and SPDX stuff
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+L:	linux-spdx@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
+F:	COPYING
+F:	LICENSES/
+F:	scripts/spdxcheck-test.sh
+F:	scripts/spdxcheck.py
+
 LIGHTNVM PLATFORM SUPPORT
 M:	Matias Bjorling <mb@lightnvm.io>
 W:	http://github/OpenChannelSSD

