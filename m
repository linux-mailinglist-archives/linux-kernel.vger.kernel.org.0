Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220362C7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfE1Nl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 09:41:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfE1NlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:41:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3C80AF61;
        Tue, 28 May 2019 13:41:24 +0000 (UTC)
Date:   Tue, 28 May 2019 15:41:23 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] intel-svm: fix typos in code comments
Message-ID: <20190528134123.GB8151@suse.de>
References: <20190520050948.26841-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520050948.26841-1-houweitaoo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 01:09:48PM +0800, Weitao Hou wrote:
> fix acccess to access
> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
>  include/linux/intel-svm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
