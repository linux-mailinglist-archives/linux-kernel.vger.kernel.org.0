Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95057E7E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 02:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfJ2BxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 21:53:24 -0400
Received: from mellowmood.mkp.net ([104.200.29.94]:59880 "EHLO
        mellowmood.mkp.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfJ2BxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:53:24 -0400
Received: from mellowmood.mkp.net (localhost [127.0.0.1])
        by mellowmood.mkp.net (Postfix) with ESMTP id 78809BB2;
        Mon, 28 Oct 2019 21:53:22 -0400 (EDT)
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com, saurav.girepunje@gmail.com
Subject: Re: [PATCH] scsi: lpfc: Fix NULL check before mempool_destroy is not needed
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191026194712.GA22249@saurav>
Date:   Mon, 28 Oct 2019 21:53:22 -0400
In-Reply-To: <20191026194712.GA22249@saurav> (Saurav Girepunje's message of
        "Sun, 27 Oct 2019 01:17:17 +0530")
Message-ID: <yq1lft48gh9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Saurav,

> mempool_destroy has taken null pointer check into account.  so remove
> the redundant check.

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
