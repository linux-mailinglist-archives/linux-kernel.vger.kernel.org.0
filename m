Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B78CB454
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 08:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfJDGKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 02:10:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387618AbfJDGKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:10:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6438AF85;
        Fri,  4 Oct 2019 06:10:13 +0000 (UTC)
Message-ID: <ccb8df9b0c0138b901c5d137a68960e6f024da8f.camel@suse.de>
Subject: Re: [PATCH] qla2xxx: fix a potential NULL pointer dereference
From:   Martin Wilck <mwilck@suse.de>
To:     Allen Pais <allen.pais@oracle.com>, martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Date:   Fri, 04 Oct 2019 08:10:20 +0200
In-Reply-To: <1568824618-4366-1-git-send-email-allen.pais@oracle.com>
References: <1568824618-4366-1-git-send-email-allen.pais@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-18 at 22:06 +0530, Allen Pais wrote:
> alloc_workqueue is not checked for errors and as a result,
> a potential NULL dereference could occur.
> 
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
>  drivers/scsi/qla2xxx/qla_os.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Martin Wilck <mwilck@suse.com>


