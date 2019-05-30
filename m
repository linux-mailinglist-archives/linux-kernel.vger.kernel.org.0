Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9A302A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 21:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfE3TKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 15:10:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45135 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725961AbfE3TKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:10:52 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4UJARH1011458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 15:10:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E599B420481; Thu, 30 May 2019 15:10:26 -0400 (EDT)
Date:   Thu, 30 May 2019 15:10:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gaowei Pu <pugaowei@gmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] jbd2: fix some print format mistakes
Message-ID: <20190530191026.GG2998@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Gaowei Pu <pugaowei@gmail.com>, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20190523022603.13539-1-pugaowei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523022603.13539-1-pugaowei@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:26:03AM +0800, Gaowei Pu wrote:
> There are some print format mistakes in debug messages. Fix them.
> 
> Signed-off-by: Gaowei Pu <pugaowei@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
