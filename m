Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C0DE40F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 03:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfJYBUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 21:20:34 -0400
Received: from mellowmood.mkp.net ([104.200.29.94]:59738 "EHLO
        mellowmood.mkp.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388707AbfJYBUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:20:33 -0400
Received: from mellowmood.mkp.net (localhost [127.0.0.1])
        by mellowmood.mkp.net (Postfix) with ESMTP id 05033BC9;
        Thu, 24 Oct 2019 21:11:13 -0400 (EDT)
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] scsi: lpfc: lpfc_attr.c: Fix Use plain integer as NULL pointer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191024025726.GA31421@saurav>
Date:   Thu, 24 Oct 2019 21:11:13 -0400
In-Reply-To: <20191024025726.GA31421@saurav> (Saurav Girepunje's message of
        "Thu, 24 Oct 2019 08:27:29 +0530")
Message-ID: <yq1y2x9bpe6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Saurav,

> Replace assignment of 0 to pointer with NULL assignment.

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
