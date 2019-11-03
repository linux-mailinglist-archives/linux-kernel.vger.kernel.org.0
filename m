Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11B1ED32E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 12:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfKCLll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 06:41:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfKCLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZCPsWSsvJ2X47Dg/6yvRov7fxoPfL44SgTK8bR4lcPw=; b=EH5LoO9v8Pw5HZZ4RveUD7JCC
        /4dfubxFytG37zFYuBQoIkDEUFao0oYjlLSMqGJmSHbGa4Q3LlCS1C6E+v+jAoWplTUyWSBSuCtAt
        OUN23ZQ+g5ZWKP+SRH3qS4J9ncw6devdRy6DnlP7+13U/7fWe0q89zWzG4yTX8Mndh07F38amTIYk
        tGhJIrRYi+uoA6yn9/GcIe5L9/vdKLjlSZbH7caVS9YJvSnnDYf3ENdpnD33dTItadE0gCNVBLEBe
        sgGYyZo1yqtJNCejaU3ojn+aDZPbeNStMOkAoOkmWo7LGa8JwMwxYjyMUOs7HQFI/EB7Yp5as+xtW
        e7FeocOkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iREGK-00080P-O9; Sun, 03 Nov 2019 11:41:40 +0000
Date:   Sun, 3 Nov 2019 03:41:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 4/5] idr: Handle integer overflow correctly
Message-ID: <20191103114140.GD15832@bombadil.infradead.org>
References: <20191103114012.30027-1-willy@infradead.org>
 <20191103114012.30027-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103114012.30027-6-willy@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 03:40:11AM -0800, Matthew Wilcox wrote:
> If there is an entry at INT_MAX then idr_for_each_entry() will increment
> id after handling it.  This is undefined behaviour, and is caught by
> UBSAN.  Adding 1U to id forces the operation to be carried out as an
> unsigned addition which (when assigned to id) will result in INT_MIN.
> Since there is never an entry stored at INT_MIN, idr_get_next() will
> return NULL, ending the loop as expected.

This was an earlier version which got left around in the git format-patch
directory.  Please ignore.
