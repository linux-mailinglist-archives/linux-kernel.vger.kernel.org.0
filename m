Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92552D1F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 06:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfJJEKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 00:10:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38069 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJJEKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:10:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so3015214pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 21:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=UJcSHYkyLS9g2HcZpoI2PRpiUanA4ZgkPXLt3MeRjlU=;
        b=NRIKTQ/5lVzZlZ+BGZEXIz0+tR+zTp5Hyl4nM7s6qwfmPzgPapCL2040GvTsv9+t/H
         AumM73/yfgwYwujTL7Gy6csJOI9BvkVwYdeUI3IVDP9897uDZCYXT+qdTKyaY7zqeI/U
         BpseQISF4WC4GGxmW/9BLlDcLMeKAj054hJmbECKCUzEkUX2RxwdbX2454Na4pgS/ORk
         BjLH1I5BtPXOEyI10iBu1T+vxY55jW3TsZ+HCK8f1+0q/3cLRqfm6mjuon3xfRQE1MEN
         bJLa8t+K0DQxeMhop9VoBr67HGJ12sT/xSD65B2HG9Fi3kfEGO5V1Z3m1TWW19NRmlDz
         XEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=UJcSHYkyLS9g2HcZpoI2PRpiUanA4ZgkPXLt3MeRjlU=;
        b=lvUpeA4+cghoZYJ4HtWYc+SrOhOSnJaLh4WhXEk2AAFb7yuYEyW73Wp0Ssnf/wOOpp
         RU+tXfX8o+uGmGw7i1G2dD7+g6+NJXGLpEq5cuGuKBHpqwh5treADSFKPysZTViaBQBw
         CqQVqgVtujfBKYqYTeWF2i+0eY8fVeBdnfouR2gwMwlOxxYHcbVxyZSZag69uncGtKVb
         dtYRfsuSSwdy0S4vkxKVkPpdml34no+4udUe9UHesspdi+5J3s8rgKAIb9dR1luVTZAc
         6fhmIOVEuAhUIFny9/s1IWjafHkxQdnRYV+UrHA7amU3TbNITrbjr27hdasKr+1UisVf
         oasg==
X-Gm-Message-State: APjAAAUoI6xrXPg6CrCFOOaIPsBc+/N5EZ90b+V88C3C2IRr88dNUcie
        m1scYwmpxBt1crFVBdgXMCpdHg==
X-Google-Smtp-Source: APXvYqxIpkjNG0HuZBQUpsyPMQikG470tsb4kk2XRUCpUECWCfEvE6VkDu3bSw/SJQXnrD/BpN+RIg==
X-Received: by 2002:a17:90a:9f42:: with SMTP id q2mr8591781pjv.95.1570680650051;
        Wed, 09 Oct 2019 21:10:50 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id q3sm4049200pgj.54.2019.10.09.21.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:10:49 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:10:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ethernet: xgmac don't set .driver twice
Message-ID: <20191009211037.2db1c1b6@cakuba.netronome.com>
In-Reply-To: <20191009132627.316-1-ben.dooks@codethink.co.uk>
References: <20191009132627.316-1-ben.dooks@codethink.co.uk>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Oct 2019 14:26:27 +0100, Ben Dooks wrote:
> Cleanup the .driver setup to just do it once, to avoid
> the following sparse warning:
> 
> drivers/net/ethernet/calxeda/xgmac.c:1914:10: warning: Initializer entry defined twice
> drivers/net/ethernet/calxeda/xgmac.c:1920:10:   also defined here
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks
