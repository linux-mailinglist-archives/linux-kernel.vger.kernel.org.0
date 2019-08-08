Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB12B857EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 04:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfHHCDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 22:03:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40499 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfHHCDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:03:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so43137467pfp.7;
        Wed, 07 Aug 2019 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILW9Vdo4/bKAEhoIm3wnpsycskjcLO+PgaF3VKWmkK4=;
        b=YW4dVUVgnjRAchN+hoV8X6LaGtaLjtGTsMvwEZL32lpWw2soWZAfgca/X5fNg0Z+M8
         HJShnYVIaFONhIcRFuXuhR7NGkVa1ki+mtaliy5+hT/ICjGvGYX1igVzUO0/J5mK8QN5
         YoKMjyD+eVuSEvlxQQH8i16f74BzP0Sna/x0Xslwk6c/WnHmTWwY9ubP/vl8L2KApbtv
         P9UKA9bgfk72saimSpzrwtNhpMN72Xl/PEemCXp3Kh9dsydJsglUS2EoKjOcfMR8JMN9
         cKh2aEn+lfL0LwkLByuTXl0kNLrh+KnlH+5khrUATLleRdyIQyrAugW4VUQf8si9VCEd
         f6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILW9Vdo4/bKAEhoIm3wnpsycskjcLO+PgaF3VKWmkK4=;
        b=TcqNTfbKV6RTaV51NYvVYp0SlHQYzkKIjCyn/sxgf1Uzq25cKkXJvWUE3jhtvvSVBY
         dFogEKT51oC/UudGSN8eA4qWkMiW/i4dKmaMU3IxizZ6Tv9qdavSgETzAyY5k3Tnz1Jb
         OpesXei2Jum56sfo5wKWgnLGFzIbYbOA2U4Q20zh2LQI0SqHFoLjUKwOkQWy5dQ7go1V
         WDh2TgeCXU7vvjd//yft/CjW6KLV/o4LgUIJ7sA9rVZe0u+uiPhuvekWYExyTSVP3DtZ
         5Bk/cL9C26eZdkbwRr2uf6r2wEohDoKGojr2cRv+HsteXDHe3jL4FbI17PQ17A4EOR1u
         Tp1g==
X-Gm-Message-State: APjAAAWGFh/744g7H0rSnLOq3UfKd6KtMWd5sAdWQE5twoyc6+F6OcCQ
        BT6u/TpsBu60r3CFLVdf1zpEglgG
X-Google-Smtp-Source: APXvYqxZ1INY0BSnuJhCIOyxto36qcHcOlLD1gQXF27L7KCnqbj3YUSf8Cf6p2N0/QWqoMr6e1meYw==
X-Received: by 2002:a62:e417:: with SMTP id r23mr12205293pfh.160.1565229779467;
        Wed, 07 Aug 2019 19:02:59 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id b3sm109292079pfp.65.2019.08.07.19.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 19:02:58 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
References: <20190724001100.133423-1-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <84338c58-a4e7-a701-4871-f90370d0af49@gmail.com>
Date:   Wed, 7 Aug 2019 19:02:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724001100.133423-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 7/23/19 5:10 PM, Saravana Kannan wrote:
> Add device-links to track functional dependencies between devices
> after they are created (but before they are probed) by looking at
> their common DT bindings like clocks, interconnects, etc.
> 

< snip >

I know that this series has moved on to versions 8 and 9.  And some
additional patches submitted.

Version 8 was a rebase to handle device_link changes.  The version 8
patch 0/7 description of the changes did not note any functional
changes, so I am assuming that my comments on version 7 are still
applicable.

The version 9 changes do not impact my comments.

I am sending review comments on patches 1, 2, and 3.  I will continue
review of patches later in the series when the fall out from these
review comments result in a new series.

-Frank
