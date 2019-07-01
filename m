Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C114E5C3BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 21:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfGATnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 15:43:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40079 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGATns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:43:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so15934982qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZRcJJoL75wa0BUs8kZ6qD2klmkZ3f8r+txf03jmmCh0=;
        b=UV0TIxe15gclhd22VBz2GT6OqENOpOqxFYkvkq6Z3uWBRq7slhYZ6yw1FJ8z8C3tYf
         BLMWFJut6eXvCr9qC2DoH5W4MhiHLLj0YxOyo/T+bOTmS7mus/+yzwSxkd2YK5GEnH1o
         yCRufEZBIxdLP0k0l9L4sf3TBCt5I8BsYZqoPmq0GGHzKf0Xl9Rejhuk8lQe/gnjYM07
         niJTBc7l6ZEj2pLoDeN4S6tkWFNUe4KOrf9btGW0Ikc/onfWIa8SBAST5R/ZbUncjFk7
         TUF4DIjXJomawIdXTw3eSjuM6yhGivNXuT3vMFTaNFQX9oRdfj7JkifZNb8wlyuGYZVD
         QEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZRcJJoL75wa0BUs8kZ6qD2klmkZ3f8r+txf03jmmCh0=;
        b=qIeJvO0YKUX/WddSMO7G0z6UpSMTJazg5eper/yoVNVQxH23kAS62R+a2eAlShp5fz
         pTh4+gd5LDpWFCOd965Jc6/Us9Jci7QWQs/Tgk76SDgkQKEBV2QEk6Nqi5vlF76l1TeV
         LVZuEAUDzRaKiGdHf0og+glxyJkTyqdNRqpLQb7w/ylQkqkvRkdouC0JmISqU1qBJXWm
         iToiOKuFTknCVeMrByrH9ziyXy8al5W/6eyR1ZjaiyL7qZE3LTCOPMju9M6tVkUiuVGD
         ZFvS5VZGmAYNfL6ARNE6eYJRGpWj67Gw4rYwFQHU8i88SAtOCjGkldT+uV5glTeJg6ez
         nKdA==
X-Gm-Message-State: APjAAAV1/ZG5gLNZWQPO8fBccfg/JBDVl+oS7sjdF3bS4Seq75AjoCZc
        SuNGRqApOk9aKdfEhRq833IfmA==
X-Google-Smtp-Source: APXvYqxzrKa9aB7XcJ5DWPbxKn9cshEfVg/O5s41eIPS2DO8XU8/k4vTbkISm5P247R0Q2oRNrE5+Q==
X-Received: by 2002:a0c:880b:: with SMTP id 11mr22790825qvl.185.1562010227946;
        Mon, 01 Jul 2019 12:43:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2ce6])
        by smtp.gmail.com with ESMTPSA id q36sm5971560qtc.12.2019.07.01.12.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 12:43:47 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:43:46 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 01/10] sched: introduce task_se_h_load helper
Message-ID: <20190701194345.vlikemna5d7og4q4@macbook-pro-91.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
 <20190628204913.10287-2-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628204913.10287-2-riel@surriel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:49:04PM -0400, Rik van Riel wrote:
> Sometimes the hierarchical load of a sched_entity needs to be calculated.
> Rename task_h_load to task_se_h_load, and directly pass a sched_entity to
> that function.
> 
> Move the function declaration up above where it will be used later.
> 
> No functional changes.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
