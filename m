Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1E4489E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393499AbfFMRJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 13:09:44 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:44975 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393453AbfFMRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:09:29 -0400
Received: by mail-qk1-f174.google.com with SMTP id p144so1112038qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=bkktTI29Mprq/WraaWR/iipIfzJhh3C703MvSQ8ZEuo=;
        b=SH6nMieXOV6x0XG3n36Q1FY3qs3vmVq92SmZudcVjmFRsbibFR0lsmi2u3vHELAUO5
         wZ137JahP55hpbb3NlKXidQhNhOZBHgWuyFLJkmdPdPiLSFe7FUO3GjyFfQcQUOsIAQW
         dvY8qQY+MOKXy3dRGh6BaBiH8mo+xTMqboB2hgbA728HU60TA7iZvPPJjL7t+PR4C6kC
         cdRUNupYDfO+ZUdqvkyelEyX2BMjeWyYZBVdwnWZntxiLKy4pS4l4M3bILvFHx2J50rI
         9JLRCFNev6/EJBAq5ZpzQ2S9430pT2PC8KW9zSOgoqokzZUFQpi0Y4mRITuj+JGNjicE
         zofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bkktTI29Mprq/WraaWR/iipIfzJhh3C703MvSQ8ZEuo=;
        b=beGf5H/F2eldWG53jxLRliOWGa5CvHis2KC271o5WUXLMk7e/RJpV12wziOLprxIKk
         WomdulW29hB4yVzBwa/7LOhihRqNMQ9EPeCVJiQ5ZdH+MsaMTW4bwhLf/foNDRnpIumB
         AmQyynSgHcA+IGP+hRBwbBrFDqopRpRrBOzT7iVBB2KVyx2TKpni6dofml1aNe+T5yiN
         c7xzOD8srQK/o+kO4Ykj5igU5YvxVUfJqwW5rD2s47qsnKzGRJHj7tDXsIcKO6VUA7Kk
         7FB2byJYPKwaSgSoS3AMQFPyLs5qVu89lKWpdZ/1tOwQZfPXIdEopo50RLwmY0pRrqoW
         JnYQ==
X-Gm-Message-State: APjAAAWNHBTmqu9eESShOVDfHLf0kuy4qZfCIWjh5Qax1Wn8fvkZxuvS
        muhdhQEzMLBR4yjwjVlayrQxwA==
X-Google-Smtp-Source: APXvYqxOtlsJBNr4RXkYgj3XdzHIOqikXnzMKvAi6Mz6sFxjcG+k9LyFuV8RHHVv9ENQS6UdATtSwQ==
X-Received: by 2002:a37:9a50:: with SMTP id c77mr72065503qke.12.1560445767909;
        Thu, 13 Jun 2019 10:09:27 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h4sm72458qkk.39.2019.06.13.10.09.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 10:09:27 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:09:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     peterz@infradead.org, netdev@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 0/2] enable and use static_branch_deferred_inc
Message-ID: <20190613100923.397a6081@cakuba.netronome.com>
In-Reply-To: <20190613150816.83198-1-willemdebruijn.kernel@gmail.com>
References: <20190613150816.83198-1-willemdebruijn.kernel@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 11:08:14 -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> 1. make static_branch_deferred_inc available if !CONFIG_JUMP_LABEL
> 2. convert the existing STATIC_KEY_DEFERRED_FALSE user to this api

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks/sorry :)
