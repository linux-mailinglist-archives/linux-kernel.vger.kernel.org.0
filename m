Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8545B86423
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbfHHOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 10:14:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43349 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfHHOOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:14:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id r26so8186390pgl.10;
        Thu, 08 Aug 2019 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7bnDPBl+prFE1mH1lAMjS/D8A3vOzqkNRoD/m+13IiI=;
        b=AFWgh9U2xiINWQ1s29QRXcbV9I6jV3Div9wTDGBSkKlOP7V3bExxa+r+BLcWuLVrBT
         B/brPXTlMeVvF3dePNRoThq6vNYGVlFh5MTg9PQ0n4g8ZUiOsb7Vn2vpVcSxLlPLRUUX
         QtU/08J8GVgYzliMekr0fUoe02copdN9BbwTN6XeAFCf0dTpMeoWoCTnuI80dBtFzzfl
         aRGi6gniuRNsio+UGLyK1DCqPA8qfRJ9qIXAt8J4vEoXYOgxwgjyTSPvKzgTtQArWVYP
         TDa7Q7Je3q/KaMEsiklbQgfTCMcIGeIVr/onIn72NhqeMZMpK+CXOVoRRS+RwMvcCJpX
         z+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7bnDPBl+prFE1mH1lAMjS/D8A3vOzqkNRoD/m+13IiI=;
        b=eTZC04aOtndZp7/UfypDOcA3FCV8CEm5bxRbOm2pRIchdh4UlZaOmC8/zKoQjCaG+7
         sxOKmgVUmiDsjaN+bAVg9g/k5uNgvO93Tyvxf1BVBpZAy4WiCwFUVdhZ4pvutRirFel/
         bHRC7ZP+pctMgjBItu00i8cSeSIH1sw1eyeyRyPFtx76jijuCPiNjSgt7ly4X13Iq2ii
         DtAAUIGEiQVBPn9/HdNDsYWK1+MZq198vsTt+kEc7YPwRC/Br+MlQVBkjt8js0uiXIP1
         U0TlgFdiOWb7S+LpIu+gKYYv4nIWobARIiz54eL6MYmt28m0CKYyOFf0iwP8n+l8dcDg
         CBxA==
X-Gm-Message-State: APjAAAWXivzeSK1OSD8pczHDC3aqfj6zVx3n2gEqF2GukpvHw7WbVNga
        ncnYIZDAmKT9oU9S2DV9dg+jVw/LjMk=
X-Google-Smtp-Source: APXvYqx2bD2kwHG4h2zschyViAYzSluA10+0wNRsPdwPQd73aarj6+VbjDVmpHKK/EiG8sUw/mX2Kw==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr4350952pjq.41.1565273673634;
        Thu, 08 Aug 2019 07:14:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s6sm138228551pfs.122.2019.08.08.07.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:14:33 -0700 (PDT)
Date:   Thu, 8 Aug 2019 07:14:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Iker Perez <iker.perez@codethink.co.uk>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add support for variable sample time in lm75
 driver
Message-ID: <20190808141432.GA10923@roeck-us.net>
References: <20190808080246.8371-1-iker.perez@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808080246.8371-1-iker.perez@codethink.co.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:02:42AM +0100, Iker Perez wrote:
> From: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
> 
> Hello,
> 
> The objective of following patch series is to add support to lm75 driver
> to be able to configure the sample time of it's supported devices,
> particularly the tmp75b.
> 
> The applied changes involve:
> 	* Replace the current switch-case method for configuration
> 	  parameters selection to a structure storing them. This method
> 	  allows easier management of the parameters.
> 	* Split the writing of configuration registers into a separate
> 	  function. This method saves code in later patches.
> 	* Include new fields in lm75_params to add support for multiple
> 	  sample times.
> 	* Split the lm75_write functionality into separate, simpler,
> 	  functions.
> 	* Add support for configuring the devices via their sysfs nodes.
> 
> The patch series was based on linux-next's master branch.
> 
> Thank you Guenter Roeck, Michael Drake, Thomas Preston and Tom Eccles for
> your time, help and feedback.
> 

Series applied to hwmon-next.

Thanks,
Guenter
