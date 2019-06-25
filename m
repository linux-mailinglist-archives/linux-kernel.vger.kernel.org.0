Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38204555CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfFYRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 13:23:39 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:55562 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726455AbfFYRXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:23:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A22036130;
        Tue, 25 Jun 2019 17:23:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:152:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2691:2892:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:7577:7875:7903:8957:9010:9040:10004:10848:11026:11232:11658:11914:12296:12297:12438:12740:12895:13095:13161:13172:13229:13618:13894:14096:14097:14181:14659:14721:14819:21080:21220:21324:21433:21451:21627:21795:21819:30003:30022:30034:30046:30051:30054:30062:30070:30075:30083:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: title47_3c983a7292d5d
X-Filterd-Recvd-Size: 5599
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Jun 2019 17:23:36 +0000 (UTC)
Message-ID: <8d416a7b0dad3933ceb8d12c9efaad541f7cf269.camel@perches.com>
Subject: Re: [PATCH v2] get_maintainer: Add --prefix option
From:   Joe Perches <joe@perches.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jun 2019 10:23:34 -0700
In-Reply-To: <20190625163701.xcb2ue7phpskvfnz@linutronix.de>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
         <20190624133333.GW3419@hirez.programming.kicks-ass.net>
         <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
         <20190625163701.xcb2ue7phpskvfnz@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 18:37 +0200, Sebastian Andrzej Siewior wrote:
> The --prefix option adds a Cc: prefix by default infront of the email
> address so it can be used by other Scripts directly instead of adding
> another wrapper for this.
> The option takes an optional argument so "--prefix=Bcc: " is also valid.
> Since it is expected to be output an email address it implies
> "--no-roles --no-rolestats".
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On 2019-06-24 07:27:47 [-0700], Joe Perches wrote:
> > On Mon, 2019-06-24 at 15:33 +0200, Peter Zijlstra wrote:
> > > Would it make sense to make '--cc' imply --no-roles --no-rolestats ?
> > 
> > Maybe.
> > 
> > It's also unlikely to be sensibly used with mailing
> > lists so maybe --nol too.
> 
> I don't see a problem with lists

This isn't acceptable to me in its current form.

The most likely use case for this is to add
"CC: <foo>" entries to a commit description.

I doubt anyone cares about the cc'd mailing lists
in a commit description.

I'd prefer that commit descriptions don't have
"CC:" lines at all as it was really only useful
for adding email address to a proposed patch and
as commit information is actually pretty useless.

There are now simple ways to make sure a patch
submission is cc'd to appropriate parties.

git send-email supports --cc-cmd

> but I think it would make sense to
> imply also "--nomoderated" once available.

I do not believe that's true.

I want to proposed patches to moderated lists
and believe everyone really should too.

I don't care if moderated lists send a
"waiting for moderation" message as long as the
list gets the proposed patch eventually.

I think only Peter cares about those, to him,
superfluous "being moderated" messages.

> v1…v2:
> 	- use --prefix instead --cc with "Cc: " as the default argument
> 	  if not specified
> 	- imply --no-roles --no-rolestats
> 
>  scripts/get_maintainer.pl | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> @@ -46,6 +46,8 @@ my $output_multiline = 1;
>  my $output_separator = ", ";
>  my $output_roles = 0;
>  my $output_rolestats = 1;
> +my $output_prefix = undef;
> +my $cc_prefix = "";

Not necessary

>  my $output_section_maxlen = 50;
>  my $scm = 0;
>  my $tree = 1;
> @@ -252,6 +254,7 @@ if (!GetOptions(
>  		'multiline!' => \$output_multiline,
>  		'roles!' => \$output_roles,
>  		'rolestats!' => \$output_rolestats,
> +		'prefix:s' => \$output_prefix,

I'd prefer the user specify the prefix.

>  		'separator=s' => \$output_separator,
>  		'subsystem!' => \$subsystem,
>  		'status!' => \$status,
> @@ -298,6 +301,16 @@ $output_multiline = 0 if ($output_separator ne ", ");
>  $output_rolestats = 1 if ($interactive);
>  $output_roles = 1 if ($output_rolestats);
>  
> +if (defined($output_prefix)) {
> +    if ($output_prefix eq "") {
> +         $cc_prefix = "Cc: ";

> +    } else {
> +         $cc_prefix = $output_prefix;
> +    }
> +    $output_rolestats = 0;
> +    $output_roles = 0;

I do not care for this.

If a switch is specified on the command line,
it should be followed.

> +}
> +
>  if ($sections || $letters ne "") {
>      $sections = 1;
>      $email = 0;
> @@ -1037,6 +1050,7 @@ version: $V
>    --separator [, ] => separator for multiple entries on 1 line
>      using --separator also sets --nomultiline if --separator is not [, ]
>    --multiline => print 1 entry per line
> +  --prefix => prints a prefix infront of the entry. CC: is default if not specified

infront isn't a word.

>  
>  Other options:
>    --pattern-depth => Number of pattern directory traversals (default: 0 (all))
> @@ -2462,9 +2476,9 @@ sub merge_email {
>  	my ($address, $role) = @$_;
>  	if (!$saw{$address}) {
>  	    if ($output_roles) {
> -		push(@lines, "$address ($role)");
> +		push(@lines, "$cc_prefix" . "$address ($role)");

It should not be $cc_prefix either, but $output_prefix

>  	    } else {
> -		push(@lines, $address);
> +		push(@lines, "$cc_prefix" . "$address");
>  	    }

And this should become something like:

	if (!$saw($address)) {
		my $output_address = "";
		$output_address .= "$output_prefix " if (defined $output_prefix);
		$output_address .= $address;
		$output_address .= " ($role)" if ($output_roles);
		push(@lines, $output_address);
		$saw{$address} = 1;
	}


