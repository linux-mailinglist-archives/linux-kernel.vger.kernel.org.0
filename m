Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31163185CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 14:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgCONjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 09:39:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45392 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgCONjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 09:39:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id b22so6600340pls.12;
        Sun, 15 Mar 2020 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0QOFfAOBJOq2HeS3oqXm7I91+7G4QDygxLF6LzvzEeM=;
        b=ib9RdXN489Mtfrx1w5iCEo9XJdjIkOJxO+Xc1ZlTSYtaGsIH8n6snqPz8Hq0sWCE5p
         WUoBXn6n/A/U3F3cBhaWxWGDAKNSfAy2QBi3mE9Grtd/swZ5wtYfKxjbPla1Mr+ebf2J
         sPixURlNLKkbrskXcBIQ5PfzYWtfRfzO62IIqnBXSSDoycMipkn2IYLk5nPt4m6JBslS
         gFoPfA8fAti9y67R9en5IdTm4AkyjbfdkFDedAQX5/kgsJ5fw7sjDjFVvmF6kSnH0HdM
         LRODeTrKobjCnIyXseyE7crp2CRTqssrV6h66xDKBAUYI4zd6zvJuk5ndkKnyHLIRO4T
         kztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0QOFfAOBJOq2HeS3oqXm7I91+7G4QDygxLF6LzvzEeM=;
        b=XcunoInhcaDaeijg0S7sevNeKDi9eFX5tZ4fzF2HU8CRyII6jDF/uYbQz54rs9Jb41
         xI4/vdLrX1nkPJqFI/mwMMjndxZLQma7y3B+e66lUSeFmCz1EKboqri8NGG4SjFTNbxF
         qsbutHRgpfv7676ZX24tT1331is+lggWHOSxhJZOnWGhFUy7YS5oFcek13kf+aPNoL+r
         sk6SH+2jHTfWIBD+t7mMm36JTQbSBu1iXFtjr0xdnSHswpJ3bVfZoVmQEz5MuAX77mr+
         YKrVU+0OQVvV+xdKEy7DDQSCW4DkW23H0onX6319jt8pfzTW+NmK1PJykpJbm+V+glrI
         lHMg==
X-Gm-Message-State: ANhLgQ26NdJ0fSc1tjqIzUoqxiOsZo62Ek37U/702tijh9xVJ8ulmPBa
        sqRRS45NWVjS396vsQNXQ5A=
X-Google-Smtp-Source: ADFU+vtpvhlOjFlMKyLFkOCUiZNksgFowWlghuIXZVi5hBE90CQiGHHwxltYqCIAf616hz5uR6hdBg==
X-Received: by 2002:a17:902:8608:: with SMTP id f8mr22248704plo.110.1584279563961;
        Sun, 15 Mar 2020 06:39:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p9sm17139805pjo.28.2020.03.15.06.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 06:39:23 -0700 (PDT)
Date:   Sun, 15 Mar 2020 06:39:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, bjwyman@gmail.com
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Add another PSU CCIN to version
 detection
Message-ID: <20200315133922.GA6231@roeck-us.net>
References: <1583948590-17220-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583948590-17220-1-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:43:10PM -0500, Eddie James wrote:
> There is an additional CCIN for the IBM CFFPS that may be classifed as
> either version one or version two, based upon the rest of the bits of
> the CCIN. Add support for it in the version detection.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter
