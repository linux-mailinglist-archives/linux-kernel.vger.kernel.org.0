Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32466E41DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 04:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391382AbfJYCxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 22:53:52 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:35707 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389230AbfJYCxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:53:51 -0400
Received: by mail-pg1-f178.google.com with SMTP id c8so557688pgb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 19:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LIAxzZdUB/yYNUMYUR2KW+Y1d8eGDKKE+QAPPE4WwsY=;
        b=Vz7o7lQSTD6qHd8pLVTzTEbjC3I5zYa86pniTc6E8MwTONeHhHKlqf9rq+Iniayq4x
         QuxjKOVu3+KCRr/GpbvTRqba9Cm+o+aa8CQo89l8JfaCutV5qrAvKWQ/xt1sNqbHZqp9
         Mkcp1qd/TLYt+odIYQb1Lh7gKcSnRu+SriiDu3NSZYv1lbI944GPXRgD3z7mx+E5UOqa
         pej0kWb1PQSK8A7e+1AtvSm3jNGi6510Tb/zdjFj1c0FiugBs2nTj6vuWARJh+/jHYpZ
         BtGzS0J3f/hi/saT+EcgO59Yta52WpgIqIGAjDTwXJyIG0bPtxlikXRcpG9wkTZ+EMIM
         w92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LIAxzZdUB/yYNUMYUR2KW+Y1d8eGDKKE+QAPPE4WwsY=;
        b=Ab2wro4uGrmH6bioc+Ftnhj7Rx8jr8KrMprTpAboVxhBmpZm+pkNzgvVUmhtcVGxH9
         M2RtOqr9fGp+eelr1Vx6WSSOinZ8jApt6Ms9vkYhYD7ygubu/tVqVZGzfTOHlJoMszku
         uoDoZVlNpSw19Y8aRt1fxAwx34l5ieek8kPk7+rw4PufnXYWjG2kMKOu1USJIH9PgxFv
         AZKscpWHDyYyHeHZeV7TiqH9ZW0w2rDQ0YPBLzTKsqSIZrPGdMJdkHzagNeLFdIc4Buq
         BHEcg1DaWEnlVdblElEBlIJ3GeA+u00JkCPk+ZejExTO6tvMu6CZRYL4HlpoeDEweZSI
         Rc+w==
X-Gm-Message-State: APjAAAXcJ2ElRNxshWlcMfQQmwB6qyJTkn56RA+r7ShLQ/sKQ8XgFTKg
        Y+zxVvxvftflwNXTjqVkRYft0w==
X-Google-Smtp-Source: APXvYqw6+uxpZOQ1bKlEOo2fMWZXsuQqMpl1CAftf0fRvSZKWwcW1De5GpA5fGKl8LGe6rGoWu23rA==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr1482308pgv.284.1571972030760;
        Thu, 24 Oct 2019 19:53:50 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id m65sm4232784pje.3.2019.10.24.19.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 19:53:49 -0700 (PDT)
Date:   Fri, 25 Oct 2019 08:23:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: processor: Add QoS requests for all CPUs
Message-ID: <20191025025343.tyihliza45os3e4r@vireshk-i7>
References: <2435090.1mJ0fSsrDY@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2435090.1mJ0fSsrDY@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-19, 02:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The _PPC change notifications from the platform firmware are per-CPU,
> so acpi_processor_ppc_init() needs to add a frequency QoS request
> for each CPU covered by a cpufreq policy to take all of them into
> account.
> 
> Even though ACPI thermal control of CPUs sets frequency limits
> per processor package, it also needs a frequency QoS request for each
> CPU in a cpufreq policy in case some of them are taken offline and
> the frequency limit needs to be set through the remaining online
> ones (this is slightly excessive, because all CPUs covered by one
> cpufreq policy will set the same frequency limit through their QoS
> requests, but it is not incorrect).
> 
> Modify the code in accordance with the above observations.

I am not sure if I understood everything you just said, but I don't
see how things can break with the current code we have.

Both acpi_thermal_cpufreq_init() and acpi_processor_ppc_init() are
called from acpi_processor_notifier() which is registered as a policy
notifier and is called when a policy is created or removed. Even if
some CPUs of a policy go offline, it won't matter as the request for
the policy stays and it will be dropped only when all the CPUs of a
policy go offline.

What am I missing ?

-- 
viresh
