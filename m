Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8A1127A36
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 12:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfLTLq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 06:46:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:48622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfLTLq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:46:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DBF55AC8F;
        Fri, 20 Dec 2019 11:46:24 +0000 (UTC)
Subject: Re: [PATCH v2] xen/grant-table: remove multiple BUG_ON on
 gnttab_interface
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20191217205356.29172-1-pakki001@umn.edu>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <4b28a38a-0437-22ae-67ca-9d4d6f8fdb18@suse.com>
Date:   Fri, 20 Dec 2019 12:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217205356.29172-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.19 21:53, Aditya Pakki wrote:
> gnttab_request_version() always sets the gnttab_interface variable
> and the assertions to check for empty gnttab_interface is unnecessary.
> The patch eliminates multiple such assertions.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
