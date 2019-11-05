Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C12EF67D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 08:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbfKEHjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 02:39:15 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:53892 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbfKEHjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:39:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4B18A27E038D;
        Tue,  5 Nov 2019 08:39:13 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WZi-j-psq1ez; Tue,  5 Nov 2019 08:39:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id F036727E0F36;
        Tue,  5 Nov 2019 08:39:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu F036727E0F36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572939553;
        bh=hx3mdGmfd3A2yXNYBNKBzEOSJVTZytIssECNKp+fs20=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Aik5qMka4c770O4AN3iXBLTgAalac4IbTDZLpvx5Mb6cJci82VimmN9/nTzsXJB4T
         D+UnQMtj7Se5PLeC6O6ZGFVZcMP/6KshMbWZ9/WDl2cj2JCk6gpIZr3+e1avzmSpe4
         R4fV0ZVl6GWEBXzh+aH504wEHf48TXUZnoXwnKqc=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sGIeDZDhfzy7; Tue,  5 Nov 2019 08:39:12 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D596627E038D;
        Tue,  5 Nov 2019 08:39:12 +0100 (CET)
Date:   Tue, 5 Nov 2019 08:39:12 +0100 (CET)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Charles Machalow <csm10495@gmail.com>
Cc:     linux-nvme <linux-nvme@lists.infradead.org>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <442718702.90376810.1572939552776.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20191105061510.22233-1-csm10495@gmail.com>
References: <20191105061510.22233-1-csm10495@gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark
 rsvd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
Thread-Index: PH7LCSaTYLN4Dj3ginxBCp3tHjyCGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 5 Nov, 2019, at 07:15, Charles Machalow csm10495@gmail.com wrote:

> Changing nvme_passthru_cmd64 to add a field: rsvd2. This field is an explicit
> marker for the padding space added on certain platforms as a result of the
> enlargement of the result field from 32 bit to 64 bits in size.
> ---
> include/uapi/linux/nvme_ioctl.h | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
> index e168dc59e..d99b5a772 100644
> --- a/include/uapi/linux/nvme_ioctl.h
> +++ b/include/uapi/linux/nvme_ioctl.h
> @@ -63,6 +63,7 @@ struct nvme_passthru_cmd64 {
> 	__u32	cdw14;
> 	__u32	cdw15;
> 	__u32	timeout_ms;
> +	__u32   rsvd2;
> 	__u64	result;
> };
> 

Looks good to me. However, please note that the new ioctl made it already to 5.3.8.

Regards,
Marta
