Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9436B19215C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 07:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgCYGya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 02:54:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46004 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 02:54:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so683230pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 23:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=UaqlU+P1/K074V4vRiZK/tqr7IfvCvV4/U+wYHOzQ75q9gMkO1HbIXkKPVp/2srFgn
         KHf/4ZKP18E+63LJkKNUBwWWNW5IFZftM+3Atap9Ex+RBpuk+QzpX/+KkLYvVd7SBSHv
         onaONIhhuDUFD3kGRWMWJY7jq+7uu1tMH2hl3brrrkbsw53SaEmRBnJM3+vWAFMkdYBA
         6OfrySOIyiQloYWF2ou6++QhqWlkdRsT1TYb6wmuDQ3ZJDmpkOy/HPTxuhIflY66WS5z
         Ydza0MTGjdMO7IiPXSvq6Lh91CHjuXQbxpJjcjjE9W+cLsLtki27S+owuAo2NPM8Gr/m
         bFpQ==
X-Gm-Message-State: ANhLgQ1vrNDV5RBjtsAd05qZos2oRHmhY+4QBPFKRscu2CU7nHJlqifo
        4nGkodA/IIO8etON+xACyrOzNgQy
X-Google-Smtp-Source: ADFU+vtqAA+ZcKesRR85r91znskVBcG7r9sIy6O4bu/R57o2CmhXpR57NnKSl/coUPcrm8LEMkJKOQ==
X-Received: by 2002:a62:1a03:: with SMTP id a3mr1852118pfa.171.1585119268930;
        Tue, 24 Mar 2020 23:54:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2c87:e6f8:1c11:1d73? ([2601:647:4802:9070:2c87:e6f8:1c11:1d73])
        by smtp.gmail.com with ESMTPSA id p22sm6705140pgn.73.2020.03.24.23.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 23:54:28 -0700 (PDT)
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
To:     Nick Bowler <nbowler@draconx.ca>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200325002847.2140-1-nbowler@draconx.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3eed9434-d1af-b0d9-e972-ddd393d1ab4b@grimberg.me>
Date:   Tue, 24 Mar 2020 23:54:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200325002847.2140-1-nbowler@draconx.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
