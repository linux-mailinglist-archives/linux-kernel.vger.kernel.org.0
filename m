Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3447F35ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 13:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfFELIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 07:08:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfFELIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:08:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45JmHM6thCz9sBb;
        Wed,  5 Jun 2019 21:08:15 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] scsi: ibmvscsi: Don't use rc uninitialized in ibmvscsi_do_work
In-Reply-To: <yq1ef48rc14.fsf@oracle.com>
References: <20190603221941.65432-1-natechancellor@gmail.com> <20190603234405.29600-1-natechancellor@gmail.com> <yq1ef48rc14.fsf@oracle.com>
Date:   Wed, 05 Jun 2019 21:08:14 +1000
Message-ID: <87woi0mgrl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin K. Petersen" <martin.petersen@oracle.com> writes:
> Nathan,
>
>> clang warns:
>>
>> drivers/scsi/ibmvscsi/ibmvscsi.c:2126:7: warning: variable 'rc' is used
>> uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>>         case IBMVSCSI_HOST_ACTION_NONE:
>>              ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Applied to 5.3/scsi-queue, thanks!

Thanks all.

cheers
